//
//  MVMoviesCollectionViewCell.swift
//  Movies
//
//  Created by Rubens Pessoa on 4/10/18.
//  Copyright © 2018 Ilhasoft. All rights reserved.
//

import UIKit

class MVMoviesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var placeholder: UIImageView!
    @IBOutlet weak var movieCover: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        movieCover.image = nil
        placeholder.isHidden = false
    }

    func setupCell(cover: UIImage) {
        movieCover.image = cover
        placeholder.isHidden = true
    }
}
