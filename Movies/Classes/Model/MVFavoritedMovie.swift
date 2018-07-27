//
//  MVFavoritedMovies.swift
//  Movies
//
//  Created by Rubens Pessoa on 4/27/18.
//  Copyright © 2018 Ilhasoft. All rights reserved.
//

import Foundation
import Parse

class MVFavoritedMovie: PFObject {
    
    var movieId: Int!
    var userId: Int!

    override class func registerSubclass() {
        super.registerSubclass()
    }
}

extension MVFavoritedMovie: PFSubclassing {
    static func parseClassName() -> String {
        return "FavoritedMovies"
    }
}
