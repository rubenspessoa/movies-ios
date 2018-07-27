//
//  MVCrew.swift
//  Movies
//
//  Created by Rubens Pessoa on 4/16/18.
//  Copyright © 2018 Ilhasoft. All rights reserved.
//

import Foundation
import ObjectMapper

class MVCrew: Mappable {
    var department: String!
    var job: String!
    var name: String!
    var profilePath: String!

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        self.department <- map["department"]
        self.job <- map["job"]
        self.name <- map["name"]
        self.profilePath <- map["profile_path"]
    }
}
