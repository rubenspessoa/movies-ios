//
//  FBSDKClient.swift
//  Movies
//
//  Created by Rubens Pessoa on 4/5/18.
//  Copyright © 2018 Ilhasoft. All rights reserved.
//

import Foundation
import Parse

class FBSDKClient {

    static let shared = FBSDKClient()

    func login(completion: @escaping (_ success: Bool, _ error: Error?) -> Void) {
        PFFacebookUtils.facebookLoginManager().loginBehavior = FBSDKLoginBehavior.native
        PFFacebookUtils
            .logInInBackground(withReadPermissions: ["public_profile"]) { (user, error) in
            guard let user = user as? MVUser, error == nil else {
                completion(false, error)
                return
            }

            FBSDKGraphRequest(graphPath: "me",
                              parameters: ["fields": "name, picture.type(large)"])
                .start(completionHandler: { (_, result, error) -> Void in
                    guard error == nil,
                        let result = result as? [String: Any],
                        let name = result["name"] as? String else {
                            completion(false, error)
                            return
                    }

                    if let imageDict = result["picture"] as? [String: Any],
                        let data = imageDict["data"] as? [String: Any],
                        let imageRawURL = data["url"] as? String,
                        let imageURL = URL(string: imageRawURL),
                        let imageData = NSData(contentsOf: imageURL),
                        let image = UIImage(data: imageData as Data),
                        let imageJPEG = UIImageJPEGRepresentation(image, 0.6),
                        let thumbnailJPEG = UIImageJPEGRepresentation(image, 0.9) {

                        let media = MVMedia()
                        media.image = PFFile(name: "image.jpg", data: imageJPEG)
                        media.thumbnail = PFFile(name: "thumb.jpg", data: thumbnailJPEG)
                        user.picture = media
                    }

                    user.name = name
                    user.saveInBackground(block: { (success, error) in
                        guard success, error == nil else {
                            completion(false, error)
                            return
                        }
                        completion(true, nil)
                    })
            })
        }
    }
}
