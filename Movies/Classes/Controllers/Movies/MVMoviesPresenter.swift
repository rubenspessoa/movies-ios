//
//  MVSearchPresenter.swift
//  Movies
//
//  Created by Daniel Amaral on 02/03/18.
//  Copyright © 2018 Ilhasoft. All rights reserved.
//

import UIKit
import RxSwift

class MVMoviesPresenter: NSObject {

    private var page: Int = 1
    private var totalPages: Int?
    private var lastSearch: String?
    private let disposeBag = DisposeBag()
    weak var view: MVMoviesContract?
    private var dataSource: MVMoviesDataSource!
    private var movies: [MVMovie] = [] {
        didSet {
            view?.reloadList(movies: movies)
        }
    }

    init(dataSource: MVMoviesDataSource, view: MVMoviesContract) {
        self.dataSource = dataSource
        self.view = view
    }

    func getMovies(_ name: String, page: Int = 1) {
        self.lastSearch = name
        dataSource.getMovies(by: name, page: page)
            .do(onNext: { [weak self] (movieSearch) in
                guard let strongSelf = self else {
                    return
                }

                strongSelf.totalPages = movieSearch.totalPages

                if page == 1 {
                    strongSelf.movies = movieSearch.results
                } else {
                    movieSearch.results.forEach({ (movie) in
                        strongSelf.movies.append(movie)
                    })
                }
            })
            .subscribe()
            .disposed(by: disposeBag)
    }

    func getImage(by index: Int) {
        guard let path = movies[index].poster else {
            return
        }
        dataSource.getImage(by: path)
            .do(onNext: { (image) in
                self.view?.setupCell(at: index, with: image)
            })
            .subscribe()
            .disposed(by: disposeBag)
    }

    func navigateToMovieDetail(indexPath: IndexPath) {
        let movie = movies[indexPath.item]
        view?.navigateToMovieDetail(movie: movie)
    }

    func paginate() {
        guard let totalPages = totalPages,
            let lastSearch = lastSearch,
            self.page + 1 <= totalPages else {
            return
        }
        self.page += 1
        getMovies(lastSearch, page: self.page)
    }

    func moviesCount() -> Int {
        return self.movies.count
    }
}
