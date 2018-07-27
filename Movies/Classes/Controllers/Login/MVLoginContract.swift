//
//  MVLoginContract.swift
//  Movies
//
//  Created by Rubens Pessoa on 4/5/18.
//  Copyright © 2018 Ilhasoft. All rights reserved.
//

import Foundation

protocol MVLoginContract: class {
    func facebookLogin(success: Bool)
    func showLoginError(error: Error)
    func navigateToHome()
}
