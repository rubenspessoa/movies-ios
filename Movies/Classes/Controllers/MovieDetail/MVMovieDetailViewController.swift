//
//  MVMovieDetailViewController.swift
//  Movies
//
//  Created by Rubens Pessoa on 4/11/18.
//  Copyright © 2018 Ilhasoft. All rights reserved.
//

import UIKit

class MVMovieDetailViewController: UIViewController {

    var movie: MVMovie!
    var presenter: MVMovieDetailPresenter!

    @IBOutlet weak var mainActorsLbl: UILabel!
    @IBOutlet weak var soundtrackLbl: UILabel!
    @IBOutlet weak var durationLbl: UILabel!
    @IBOutlet weak var genreLbl: UILabel!
    @IBOutlet weak var releaseLbl: UILabel!
    @IBOutlet weak var directionLbl: UILabel!
    @IBOutlet weak var technicalSheet: UILabel!
    @IBOutlet weak var synopsisLbl: UILabel!
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var movieRatingLbl: UILabel!
    @IBOutlet weak var plotLbl: UILabel!
    @IBOutlet weak var movieDirector: UILabel!
    @IBOutlet weak var movieReleaseLbl: UILabel!
    @IBOutlet weak var movieGenreLbl: UILabel!
    @IBOutlet weak var movieDurationLbl: UILabel!
    @IBOutlet weak var movieTrackSoundLbl: UILabel!
    @IBOutlet weak var actorsCollectionView: UICollectionView!

    init(movie: MVMovie) {
        super.init(nibName: nil, bundle: nil)
        self.movie = movie
        presenter = MVMovieDetailPresenter(dataSource: MVMovieDetailRepository(), view: self, movie: movie)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        actorsCollectionView.dataSource = self
        actorsCollectionView.delegate = self
        setupLayout()
    }

    func setupLayout() {
        synopsisLbl.text = localizedString(.synopsis)
        technicalSheet.text = localizedString(.technicalSheet)
        directionLbl.text = localizedString(.direction)
        releaseLbl.text = localizedString(.release)
        genreLbl.text = localizedString(.genre)
        durationLbl.text = localizedString(.duration)
        soundtrackLbl.text = localizedString(.soundTrack)
        mainActorsLbl.text = localizedString(.mainActors)

        titleLbl.text = movie.title
        actorsCollectionView.register(UINib(nibName: "MVCreditsCollectionViewCell", bundle: nil),
                                      forCellWithReuseIdentifier: "CreditsCell")

        if let rating = movie.voteAverage {
            let orangeAttributes: [NSAttributedStringKey: Any] = [NSAttributedStringKey.font: movieRatingLbl.font,
                                    NSAttributedStringKey.foregroundColor: UIColor.darkTangerine]
            let orangeText = NSMutableAttributedString(string: "\(rating)", attributes: orangeAttributes)

            let whiteAttributes: [NSAttributedStringKey: Any] = [NSAttributedStringKey.font: movieRatingLbl.font,
                                   NSAttributedStringKey.foregroundColor: UIColor.white]
            let whiteText = NSMutableAttributedString(string: "/10", attributes: whiteAttributes)

            orangeText.append(whiteText)
            movieRatingLbl.attributedText = orangeText
        }

        favoriteButton.setImage(UIImage(named: "icon_favorite_off"), for: .normal)
        favoriteButton.setImage(UIImage(named: "icon_favorite_on"), for: .selected)
    }

    @IBAction func favoriteButtonTapped(_ sender: Any) {
        favoriteButton.isSelected = !favoriteButton.isSelected
        if favoriteButton.isSelected {
            // do stuff
        }
    }
}

extension MVMovieDetailViewController: MVMovieDetailContract {
    func updateMovieDetail(_ movieDetail: MVMovieDetail) {
        self.plotLbl.text = movieDetail.overview
        self.movieGenreLbl.text = ""
        if let runtime = movieDetail.runtime {
            self.movieDurationLbl.text = "\(runtime) min"
        }
        movieDetail.genres.forEach { (genre) in
            guard let name = genre.name else {
                return
            }
            self.movieGenreLbl.text?.append("\(name) ")
        }
        presenter.formatDate(from: movieDetail.releaseDate)
    }

    func updateMovieReleasedate(formattedDate: String) {
        self.movieReleaseLbl.text = formattedDate
    }

    func updateMovieCredits(_ movieCredits: MVMovieCredits) {
        self.movieTrackSoundLbl.text = ""
        self.movieDirector.text = ""
        movieCredits.crew.forEach { (crew) in
            guard let name = crew.name else {
                return
            }
            if crew.department == "Directing" {
                self.movieDirector.text?.append("\(name) ")
            } else if crew.department == "Sound" {
                self.movieTrackSoundLbl.text?.append("\(name) ")
            }
        }
        actorsCollectionView.reloadData()
    }
    
    func updateMovieFavoriteStatus(_ wasFavorited: Bool) {
        favoriteButton.isSelected = wasFavorited
    }

    func updateMoviePoster(_ image: UIImage) {
        guard let gradientImage = UIImage.applyGradient(to: image) else {
            return
        }
        self.coverImage.image = gradientImage
    }

    func setupCell(at index: Int, with image: UIImage, and name: String) {
        DispatchQueue.main.async {
            let indexPath = IndexPath(item: index, section: 0)
            guard let cell = self.actorsCollectionView.cellForItem(at: indexPath) as? MVCreditsCollectionViewCell else {
                return
            }
            cell.setupCell(image: image, name: name)
        }
    }
}

extension MVMovieDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return presenter.getCastCount()
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension MVMovieDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CreditsCell",
                                                      for: indexPath) as! MVCreditsCollectionViewCell
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        presenter.getImage(by: indexPath.item)
    }
}
