//
//  MovieTableViewCell.swift
//  Movie news
//
//  Created by Beka Zhapparkulov on 9/19/20.
//  Copyright © 2020 Kazybek. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var originalTitleLabel: UILabel!
    @IBOutlet weak var movieRealaseDateLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var rateView: UIView!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        rateView.layer.cornerRadius = rateView.frame.height/2
        movieImage.layer.masksToBounds = false
        movieImage.clipsToBounds = true
        movieImage.layer.cornerRadius = 20
    }

    @IBAction func favoriteButtonClick(_ sender: Any) {
    }
}
