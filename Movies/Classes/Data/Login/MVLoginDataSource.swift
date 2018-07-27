//
//  MVLoginDataSource.swift
//  Movies
//
//  Created by Rubens Pessoa on 4/5/18.
//  Copyright © 2018 Ilhasoft. All rights reserved.
//

import Foundation

protocol MVLoginDataSource: class {
    func facebookLogin(completion: @escaping (_ success: Bool, _ error: Error?) -> Void)
}
