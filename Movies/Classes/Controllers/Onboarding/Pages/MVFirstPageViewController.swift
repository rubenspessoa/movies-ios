//
//  MVFirstPageViewController.swift
//  Movies
//
//  Created by Rubens Pessoa on 4/3/18.
//  Copyright © 2018 Ilhasoft. All rights reserved.
//

import UIKit

class MVFirstPageViewController: UIViewController {

    @IBOutlet weak var moviesLbl: UILabel!
    @IBOutlet weak var moviesDescriptionLbl: UILabel!

    override func viewDidLoad() {
        setupLayout()
    }

    func setupLayout() {
        moviesLbl.text = localizedString(.movie)
        moviesDescriptionLbl.text = localizedString(.movieDescription)
    }
}
