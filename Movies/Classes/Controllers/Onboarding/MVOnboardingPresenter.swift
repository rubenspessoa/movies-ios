//
//  MVOnboardingPresenter.swift
//  Movies
//
//  Created by Rubens Pessoa on 4/5/18.
//  Copyright © 2018 Ilhasoft. All rights reserved.
//

import Foundation

class MVOnboardingPresenter {

    weak var view: MVOnboardingContract?

    init(view: MVOnboardingContract) {
        self.view = view
    }

    func onBeginButtonTapped() {
        view?.navigateToLogin()
    }
}
