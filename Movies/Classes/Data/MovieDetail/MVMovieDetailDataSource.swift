//
//  MVMovieDetailDatasource.swift
//  Movies
//
//  Created by Rubens Pessoa on 4/15/18.
//  Copyright © 2018 Ilhasoft. All rights reserved.
//

import Foundation
import RxSwift

protocol MVMovieDetailDataSource: class {
    func getMovieDetail(by id: String) -> Observable<MVMovieDetail>
    func getMovieCredits(by id: String) -> Observable<MVMovieCredits>
    func getImage(by path: String) -> Observable<UIImage>
}
