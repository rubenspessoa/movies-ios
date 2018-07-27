//
//  MVUser.swift
//  Movies
//
//  Created by Rubens Pessoa on 4/5/18.
//  Copyright © 2018 Ilhasoft. All rights reserved.
//

import Foundation
import Parse

class MVUser: PFUser {
    @NSManaged var picture: MVMedia?
    @NSManaged var name: String!

    override class func registerSubclass() {
        super.registerSubclass()
    }
}
