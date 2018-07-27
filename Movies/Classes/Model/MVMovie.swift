//
//  MVMovie.swift
//  Movies
//
//  Created by Daniel Amaral on 02/03/18.
//  Copyright © 2018 Ilhasoft. All rights reserved.
//

import UIKit
import ObjectMapper

class MVMovie: Mappable {

    var id: Int!
    var title: String!
    var poster: String!
    var backdrop: String!
    var voteAverage: Double!

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        self.id <- map["id"]
        self.title <- map["title"]
        self.poster <- map["poster_path"]
        self.backdrop <- map["backdrop_path"]
        self.voteAverage <- map["vote_average"]
    }
}
