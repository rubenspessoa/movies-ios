//
//  MVMedia.swift
//  Movies
//
//  Created by Rubens Pessoa on 4/5/18.
//  Copyright © 2018 Ilhasoft. All rights reserved.
//

import Foundation
import Parse

class MVMedia: PFObject {

    @NSManaged var thumbnail: PFFile!
    @NSManaged var image: PFFile!

    static func findMediaById(id: String,
                              completion: @escaping (_ media: MVMedia?, _ error: Error?) -> Void) {
        guard let query = MVMedia.query() else {
            return
        }
        query.includeKey("thumbnail")
        query.getObjectInBackground(withId: id) { (object, error) in
            if let media = object as? MVMedia {
                completion(media, nil)
            } else {
                completion(nil, error)
            }
        }
    }
}

extension MVMedia: PFSubclassing {
    static func parseClassName() -> String {
        return "Media"
    }
}
