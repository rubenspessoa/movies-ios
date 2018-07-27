//
//  MVCreditsCollectionViewCell.swift
//  Movies
//
//  Created by Rubens Pessoa on 4/16/18.
//  Copyright © 2018 Ilhasoft. All rights reserved.
//

import UIKit

class MVCreditsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        photo.image = nil
        nameLbl.text = ""
    }

    func setupCell(image: UIImage, name: String) {
        photo.image = image
        nameLbl.text = name
    }
}
