//
//  MVMovieDetailRepository.swift
//  Movies
//
//  Created by Rubens Pessoa on 4/15/18.
//  Copyright © 2018 Ilhasoft. All rights reserved.
//

import Foundation
import RxSwift

class MVMovieDetailRepository: MVMovieDetailDataSource {
    func getMovieDetail(by id: String) -> Observable<MVMovieDetail> {
        return TMDbClient.shared.getMovieDetail(by: id)
    }

    func getMovieCredits(by id: String) -> Observable<MVMovieCredits> {
        return TMDbClient.shared.getMovieCredits(by: id)
    }

    func getImage(by path: String) -> Observable<UIImage> {
        return TMDbClient.shared.getImage(by: path)
    }
}
