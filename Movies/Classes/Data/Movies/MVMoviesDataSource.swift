//
//  MVMoviesDataSource.swift
//  Movies
//
//  Created by Daniel Amaral on 07/03/18.
//  Copyright © 2018 Ilhasoft. All rights reserved.
//

import UIKit
import RxSwift

protocol MVMoviesDataSource: class {
    func getMovies(by name: String, page: Int) -> Observable<MVMovieSearch>
    func getImage(by path: String) -> Observable<UIImage>
}
