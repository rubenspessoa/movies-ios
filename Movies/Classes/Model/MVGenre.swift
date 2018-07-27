//
//  MVGenre.swift
//  Movies
//
//  Created by Rubens Pessoa on 4/15/18.
//  Copyright © 2018 Ilhasoft. All rights reserved.
//

import Foundation
import ObjectMapper

class MVGenre: Mappable {

    var name: String!

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        self.name <- map["name"]
    }
}
