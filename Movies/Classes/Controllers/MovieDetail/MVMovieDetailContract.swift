//
//  MVMovieDetailContract.swift
//  Movies
//
//  Created by Rubens Pessoa on 4/12/18.
//  Copyright © 2018 Ilhasoft. All rights reserved.
//

import Foundation
import UIKit

protocol MVMovieDetailContract: class {
    func updateMovieDetail(_ movieDetail: MVMovieDetail)
    func updateMovieCredits(_ movieCredits: MVMovieCredits)
    func updateMovieReleasedate(formattedDate: String)
    func updateMoviePoster(_ image: UIImage)
    func updateMovieFavoriteStatus(_ wasFavorited: Bool)
    func setupCell(at index: Int, with image: UIImage, and name: String)
}
