//
//  MVMoviesSearch.swift
//  Movies
//
//  Created by Rubens Pessoa on 4/15/18.
//  Copyright © 2018 Ilhasoft. All rights reserved.
//

import Foundation
import ObjectMapper

class MVMovieSearch: Mappable {
    var totalResults: Int!
    var page: Int!
    var results: [MVMovie]!
    var totalPages: Int!

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        self.totalResults <- map["total_results"]
        self.page <- map["page"]
        self.results <- map["results"]
        self.totalPages <- map["total_pages"]
    }
}
