//
//  MVLoginPresenter.swift
//  Movies
//
//  Created by Rubens Pessoa on 4/5/18.
//  Copyright © 2018 Ilhasoft. All rights reserved.
//

import Foundation
import Parse

class MVLoginPresenter {

    weak var view: MVLoginContract?
    var dataSource: MVLoginDataSource

    init(view: MVLoginContract, dataSource: MVLoginDataSource) {
        self.view = view
        self.dataSource = dataSource
    }

    func onFacebookLoginTapped() {
        dataSource.facebookLogin { success, error in
            guard success, error == nil else {
                if let error = error {
                    self.view?.showLoginError(error: error)
                }
                return
            }
            self.view?.facebookLogin(success: success)
        }
    }

    func navigateToHome() {
        view?.navigateToHome()
    }
}
