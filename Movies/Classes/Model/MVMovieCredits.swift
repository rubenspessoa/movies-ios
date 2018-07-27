//
//  MVCastSearch.swift
//  Movies
//
//  Created by Rubens Pessoa on 4/15/18.
//  Copyright © 2018 Ilhasoft. All rights reserved.
//

import Foundation
import ObjectMapper

class MVMovieCredits: Mappable {

    var cast: [MVCast]!
    var crew: [MVCrew]!

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        self.cast <- map["cast"]
        self.crew <- map["crew"]
    }
}
