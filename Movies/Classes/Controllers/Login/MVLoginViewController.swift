//
//  MVLoginViewController.swift
//  Movies
//
//  Created by Rubens Pessoa on 4/5/18.
//  Copyright © 2018 Ilhasoft. All rights reserved.
//

import UIKit
import MBProgressHUD

class MVLoginViewController: UIViewController {

    var presenter: MVLoginPresenter!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var loginBtn: UIButton!

    init() {
        super.init(nibName: nil, bundle: nil)
        presenter = MVLoginPresenter(view: self, dataSource: MVLoginRepository())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }

    func setupLayout() {
        loginBtn.setTitle(localizedString(.login), for: .normal)
        loginBtn.layer.cornerRadius = loginBtn.bounds.height/2
        loginBtn.clipsToBounds = true

        if let backgroundImage = UIImage(named: "bg_liga_da_justica") {
            backgroundImageView.image = UIImage.applyGradient(to: backgroundImage)
        }
    }

    @IBAction func loginTapped(_ sender: Any) {
        presenter.onFacebookLoginTapped()
        MBProgressHUD.showAdded(to: view, animated: true)
    }
}

extension MVLoginViewController: MVLoginContract {
    func showLoginError(error: Error) {
        let alertController = UIAlertController(title: localizedString(.oops),
                                                message: error.localizedDescription,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: localizedString(.tryAgain),
                                                style: .default) { (_) in
            self.dismiss(animated: true, completion: nil)
        })
        self.present(alertController, animated: true, completion: nil)
    }

    func facebookLogin(success: Bool) {
        MBProgressHUD.hide(for: view, animated: true)
        guard success else {
            return
        }
        presenter.navigateToHome()
    }

    func navigateToHome() {
        present(UINavigationController(rootViewController: MVMoviesViewController()), animated: true, completion: nil)
    }
}
