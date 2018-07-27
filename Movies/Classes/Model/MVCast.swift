//
//  MVCast.swift
//  Movies
//
//  Created by Rubens Pessoa on 4/15/18.
//  Copyright © 2018 Ilhasoft. All rights reserved.
//

import Foundation
import ObjectMapper

class MVCast: Mappable {

    var name: String!
    var profilePath: String!

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        self.name <- map["name"]
        self.profilePath <- map["profile_path"]
    }
}
