//
//  MainNewsTableViewController.swift
//  Movie news
//
//  Created by Beka Zhapparkulov on 9/18/20.
//  Copyright © 2020 Kazybek. All rights reserved.
//

import UIKit
import SDWebImage

protocol MovieNewsProtocol {
    var delegate: MovieNewsDelegate? {get set}
    func requestMovie()
}

class MainNewsTableViewController: UITableViewController {
    
//    var moviesSavedToRealm = MoviesSavedToRealm()
    
    
    var provider: MovieNewsProtocol?
    var movieData: [Films] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        provider = NewsProvider(delegate: self)
        provider?.requestMovie()
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(self.refreshControl!) // not required when using UITableViewCo
    }
    
    @objc func refresh(_ sender: AnyObject) {
        provider?.requestMovie()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movieData.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "moviesCellId", for: indexPath) as! MovieTableViewCell
        let movie = movieData[indexPath.row]
        let imageURL = URL(string: "https://image.tmdb.org/t/p/original" + movie.backdropPath!)        
        cell.originalTitleLabel.text = movie.title
        cell.movieRealaseDateLabel.text = movie.releaseDate
        cell.rateLabel.text = "\(movie.voteAverage ?? 0.0)"
        cell.movieImage?.sd_setImage(with: imageURL, placeholderImage: #imageLiteral(resourceName: "interface"))
        
        
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "goToDetail", sender: self)
//
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goToDetail") {
            let cell = sender as? MovieTableViewCell
            let indexPath = tableView.indexPath(for: cell!)
            let movie = movieData[indexPath!.row]
            let destination = segue.destination as? MovieDetailViewController
            destination?.movie = movie
        }
    }
}

extension MainNewsTableViewController: MovieNewsDelegate {
    func provideMovie(movies: Movies) {
        movieData = movies.results
        DispatchQueue.main.async {
            self.refreshControl!.endRefreshing()
            self.tableView.reloadData()
        }
    }
}