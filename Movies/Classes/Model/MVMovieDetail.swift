//
//  MVMovieDetail.swift
//  Movies
//
//  Created by Rubens Pessoa on 4/12/18.
//  Copyright © 2018 Ilhasoft. All rights reserved.
//

import Foundation
import ObjectMapper

class MVMovieDetail: MVMovie {

    var genres: [MVGenre]!
    var overview: String!
    var releaseDate: Date!
    var runtime: Int!

    required init?(map: Map) {
        super.init(map: map)
    }

    override func mapping(map: Map) {
        super.mapping(map: map)
        self.genres <- map["genres"]
        self.overview <- map["overview"]
        self.releaseDate <- (map["release_date"], DateTransform())
        self.runtime <- map["runtime"]
    }
}
