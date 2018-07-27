//
//  MVMoviesContract.swift
//  Movies
//
//  Created by Daniel Amaral on 06/03/18.
//  Copyright © 2018 Ilhasoft. All rights reserved.
//

import UIKit

protocol MVMoviesContract: class {
    func reloadList(movies: [MVMovie])
    func showError(error: Error)
    func navigateToMovieDetail(movie: MVMovie)
    func setupCell(at indext: Int, with image: UIImage)
}
