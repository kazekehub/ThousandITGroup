//
//  MainNewsTableViewController.swift
//  Movie news
//
//  Created by Beka Zhapparkulov on 9/18/20.
//  Copyright © 2020 Kazybek. All rights reserved.
//

import UIKit
import SDWebImage
import RealmSwift
import SideMenu

protocol MovieNewsProtocol {
    var delegate: MovieNewsDelegate? {get set}
    func getMovie(_ category: String)
}

class MainNewsTableViewController: UITableViewController, SideBarDelegate {
    
    var realmHelper = RealmHelper()
    var provider: MovieNewsProtocol?
    var movieData: [Films] = []
    let defaults = UserDefaults.standard
    var sideBarMenu: SideMenuNavigationController?
    var category = "popular?"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if defaults.bool(forKey: "First Launch") == true {
            if let movies = self.realmHelper.readMovie(){
                self.movieData = movies
            } else {
                provider?.getMovie(category)
            }
            defaults.set(true,forKey: "First Laucnh")
        } else {
            provider = NewsProvider(delegate: self)
            provider?.getMovie("popular?")
            defaults.set(true,forKey: "First Laucnh")
        }
//        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))

        let sideBarController = SideBarMenuController()
        sideBarController.delegate = self
        sideBarMenu = SideMenuNavigationController(rootViewController: sideBarController)
        sideBarMenu?.leftSide = true
        
        SideMenuManager.default.leftMenuNavigationController = sideBarMenu
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: self.view, forMenu: SideMenuManager.PresentDirection.left)
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(self.refreshControl!)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        provider?.getMovie(category)
    }
    
    //sidebar functions
    func reload(category: String, navigationBarTitle: String) {
        title = navigationBarTitle
        self.category = category
        provider?.getMovie(category)
    }
        
    func runSegue(identifier: String) {
        performSegue(withIdentifier: identifier, sender: self)
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
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == movieData.count - 1 {
            moreData()
        }
    }
    
    func moreData() {
        for _ in 0...9{
            movieData.append(movieData.randomElement()!)
        }
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetail" {
            let cell = sender as? MovieTableViewCell
            let indexPath = tableView.indexPath(for: cell!)
            let movie = movieData[indexPath!.row]
            let destination = segue.destination as? MovieDetailViewController
            destination?.movie = movie
        }
    }
    
    @IBAction func sideMenuButton(_ sender: Any) {
        present(sideBarMenu!, animated: true)
    }
}

extension MainNewsTableViewController: MovieNewsDelegate {
    func provideMovie(movies: Movies) {
        movieData = movies.results
        self.realmHelper.saveAndUpdateMovie(movies: movies.results)
        DispatchQueue.main.async {
            self.refreshControl!.endRefreshing()
            self.tableView.reloadData()
        }
    }
}
