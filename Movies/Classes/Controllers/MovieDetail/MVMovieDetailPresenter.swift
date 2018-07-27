//
//  MVMovieDetailPresenter.swift
//  Movies
//
//  Created by Rubens Pessoa on 4/12/18.
//  Copyright © 2018 Ilhasoft. All rights reserved.
//

import Foundation
import RxSwift

class MVMovieDetailPresenter {

    let disposeBag = DisposeBag()
    weak var view: MVMovieDetailContract?
    private var dataSource: MVMovieDetailDataSource!
    private var movie: MVMovie!
    private var movieDetail: MVMovieDetail? {
        didSet {
            guard let movieDetail = movieDetail else {
                return
            }
            view?.updateMovieDetail(movieDetail)
        }
    }
    private var movieCredits: MVMovieCredits? {
        didSet {
            guard let movieCredits = movieCredits else {
                return
            }
            view?.updateMovieCredits(movieCredits)
        }
    }

    init(dataSource: MVMovieDetailDataSource, view: MVMovieDetailContract, movie: MVMovie) {
        self.dataSource = dataSource
        self.view = view
        self.movie = movie

        guard let id = movie.id else {
            return
        }

        self.getMovieDetail(by: "\(id)")
        self.getMovieCredits(by: "\(id)")
        if let backdrop = movie.backdrop {
            self.getMoviePoster(by: backdrop)
        }
    }

    func formatDate(from date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale.current
        view?.updateMovieReleasedate(formattedDate: dateFormatter.string(from: date))
    }

    func getMoviePoster(by path: String) {
        dataSource.getImage(by: path)
            .do(onNext: { (image) in
                self.view?.updateMoviePoster(image)
            })
            .subscribe()
            .disposed(by: disposeBag)
    }

    func getMovieDetail(by id: String) {
        dataSource.getMovieDetail(by: id)
            .do(onNext: { (movieDetail) in
                self.movieDetail = movieDetail
            })
            .subscribe()
            .disposed(by: disposeBag)
    }

    func getMovieCredits(by id: String) {
        dataSource.getMovieCredits(by: id)
            .do(onNext: { (movieCredits) in
                self.movieCredits = movieCredits
            })
            .subscribe()
            .disposed(by: disposeBag)
    }

    func getImage(by index: Int) {
        guard let movieCredits = self.movieCredits,
            let imagePath = movieCredits.cast[index].profilePath,
            let name = movieCredits.cast[index].name else {
                return
        }

        dataSource.getImage(by: imagePath)
            .do(onNext: { (image) in
                self.view?.setupCell(at: index, with: image, and: name)
            })
            .subscribe()
            .disposed(by: disposeBag)
    }

    func getCastCount() -> Int {
        return movieCredits?.cast.count ?? 0
    }
}
