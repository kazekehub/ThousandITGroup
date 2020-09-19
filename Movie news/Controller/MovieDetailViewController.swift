//
//  MovieDetailViewController.swift
//  Movie news
//
//  Created by Beka Zhapparkulov on 9/19/20.
//  Copyright © 2020 Kazybek. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    var movie: Films?
    
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var rateRoundView: UIView!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var movieRealaseDateLabel: UILabel!
    @IBOutlet weak var filmTitleLabel: UILabel!
    @IBOutlet weak var favoriteStarButton: UIButton!
    @IBOutlet weak var movieBackgroundImage: UIImageView!
    @IBOutlet weak var voteCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = movie?.title
        rateRoundView.layer.cornerRadius = rateRoundView.frame.height/2
        let imageURL = URL(string: "https://image.tmdb.org/t/p/original" + (movie?.backdropPath)!)
        
        DispatchQueue.main.async {
            self.movieBackgroundImage.sd_setImage(with: imageURL, placeholderImage: #imageLiteral(resourceName: "interface"))
        }
        overviewLabel.text = movie?.overview
        rateLabel.text = "\(movie?.voteAverage ?? 0.0)"
        movieRealaseDateLabel.text = movie?.releaseDate
        filmTitleLabel.text = movie?.title
        voteCountLabel.text = "\(movie?.voteCount ?? 0)"
    }
    
    @IBAction func favoriteStarButtonClick(_ sender: Any) {
    }
}
