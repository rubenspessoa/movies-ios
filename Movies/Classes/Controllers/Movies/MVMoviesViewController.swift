//
//  MVSearchViewController.swift
//  Movies
//
//  Created by Daniel Amaral on 02/03/18.
//  Copyright © 2018 Ilhasoft. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MVMoviesViewController: UIViewController {

    private let disposeBag = DisposeBag()
    let searchController = UISearchController(searchResultsController: nil)
    var presenter: MVMoviesPresenter!
    @IBOutlet weak var collectionView: UICollectionView!

    init() {
        super.init(nibName: nil, bundle: nil)
        presenter = MVMoviesPresenter(dataSource: MVMoviesRepository(), view: self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        setupLayout()
        bindUI()
    }

    private func setupLayout() {
        title = localizedString(.title)
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.barStyle = .black

        // Setup navigation's right button
        let rightBarButton = UIBarButtonItem(image: UIImage(named: "icon_profile"),
                                             style: .plain,
                                             target: self,
                                             action: #selector(profileButtonTapped))
        navigationItem.rightBarButtonItem = rightBarButton

        // Setup search bar
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        definesPresentationContext = true

        collectionView.register(UINib(nibName: "MVMoviesCollectionViewCell", bundle: nil),
                                forCellWithReuseIdentifier: "MoviesCell")
        collectionView.isPrefetchingEnabled = false
    }

    private func bindUI() {
        searchController.searchBar.rx
            .text
            .orEmpty
            .debounce(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .filter({ (text) -> Bool in
                return !text.isEmpty
            })
            .subscribe(onNext: { [weak self] (text) in
                guard let strongSelf = self else {
                    return
                }
                strongSelf.presenter.getMovies(text, page: 1)
            })
            .disposed(by: disposeBag)
    }

    @objc func profileButtonTapped(sender: UIBarButtonItem) {
        print("profile button tapped")
    }

    private func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
}

extension MVMoviesViewController: MVMoviesContract {
    func reloadList(movies: [MVMovie]) {
        collectionView.reloadData()
    }

    func showError(error: Error) {
        let alertController = UIAlertController(title: localizedString(.oops),
                                                message: error.localizedDescription,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: localizedString(.tryAgain),
                                                style: .default) { (_) in
                                                    self.dismiss(animated: true, completion: nil)
        })
        self.present(alertController, animated: true, completion: nil)
    }

    func navigateToMovieDetail(movie: MVMovie) {
        let movieDetailVC = MVMovieDetailViewController(movie: movie)
        navigationController?.pushViewController(movieDetailVC, animated: true)
    }

    func setupCell(at index: Int, with image: UIImage) {
        DispatchQueue.main.async {
            let indexPath = IndexPath(item: index, section: 0)
            guard let cell = self.collectionView.cellForItem(at: indexPath) as? MVMoviesCollectionViewCell else {
                return
            }
            cell.setupCell(cover: image)
        }
    }
}

extension MVMoviesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCell",
                                                      for: indexPath) as! MVMoviesCollectionViewCell
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        presenter.getImage(by: indexPath.item)
        if indexPath.item == presenter.moviesCount() - 1 {
            presenter.paginate()
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        presenter.navigateToMovieDetail(indexPath: indexPath)
    }
}

extension MVMoviesViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return presenter.moviesCount()
    }
}
