//
//  MVSecondPageViewController.swift
//  Movies
//
//  Created by Rubens Pessoa on 4/3/18.
//  Copyright © 2018 Ilhasoft. All rights reserved.
//

import UIKit

class MVSecondPageViewController: UIViewController {

    @IBOutlet weak var collectLbl: UILabel!
    @IBOutlet weak var collectDescriptionLbl: UILabel!

    override func viewDidLoad() {
        setupLayout()
    }

    func setupLayout() {
        collectLbl.text = localizedString(.collect)
        collectDescriptionLbl.text = localizedString(.collectDescription)
    }
}
