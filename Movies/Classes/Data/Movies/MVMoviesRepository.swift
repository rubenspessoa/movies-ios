//
//  MVSearchRepository.swift
//  Movies
//
//  Created by Daniel Amaral on 02/03/18.
//  Copyright © 2018 Ilhasoft. All rights reserved.
//

import UIKit
import RxSwift

class MVMoviesRepository: MVMoviesDataSource {
    func getMovies(by name: String, page: Int) -> Observable<MVMovieSearch> {
        return TMDbClient.shared.searchMovie(by: name, page: page)
    }

    func getImage(by path: String) -> Observable<UIImage> {
        return TMDbClient.shared.getImage(by: path)
    }
}
