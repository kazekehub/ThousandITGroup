//
//  SideBarMenuController.swift
//  Movie news
//
//  Created by Beka Zhapparkulov on 9/20/20.
//  Copyright © 2020 Kazybek. All rights reserved.
//

import UIKit
import SideMenu

protocol SideBarDelegate {
    func reload(category: String, navigationBarTitle: String)
    func runSegue(identifier: String)
}

class SideBarMenuController: UITableViewController {

    var delegate: SideBarDelegate?
    let urlSkeleton = "https://api.themoviedb.org/3/movie/"
    
    struct Objects {
        var sectionName: String
        var sectionObjects: [(String?, String?)]
    }
    
    var objectsArray =
        [Objects(sectionName: "Фильмы",
                 sectionObjects: [("Популярные", "popular?"),
                                ("Сейчас смотрят", "now_playing?"),
                                ("Ожидаемые", "upcoming?"),
                                ("Лучшие", "top_rated?")]),
        Objects(sectionName: "Еще",
                sectionObjects: [("О приложении", nil)])]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.66, green: 0.66, blue: 0.66, alpha: 1)
        navigationItem.title = "The Movie DB"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectsArray[section].sectionObjects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
           cell.textLabel?.text = objectsArray[indexPath.section].sectionObjects[indexPath.row].0
           return cell
       }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
          return objectsArray.count
      }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return objectsArray[section].sectionName
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        dismiss(animated: true, completion: nil)
        if objectsArray[indexPath.section].sectionName == "Фильмы" {
            delegate?.reload(category: objectsArray[indexPath.section].sectionObjects[indexPath.row].1!, navigationBarTitle: objectsArray[indexPath.section].sectionObjects[indexPath.row].0!)
            
        } else {
            if objectsArray[indexPath.section].sectionObjects[indexPath.row].0 == "О приложении" {
                delegate?.runSegue(identifier: "aboutSegue")
            }
        }
    }
}
