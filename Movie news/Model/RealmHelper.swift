//
//  RealmHelper.swift
//  Movie news
//
//  Created by Beka Zhapparkulov on 9/20/20.
//  Copyright © 2020 Kazybek. All rights reserved.
//

import Foundation
import RealmSwift

class RealmHelper {
    
    func readMovie() -> [Films]? {
        do {
            let realm = try Realm()
            return realm
                .objects(MoviesCached.self)
                .map{Films(moviesCached: $0)}
        } catch let error as NSError {
            print("ERROR: \(error)")
        }
        return nil
    }
    
    func saveAndUpdateMovie(movies: [Films]){ 
        let realm = try! Realm()
        do {
            try realm.write {
                movies
                    .map{MoviesCached(movie: $0)}
                    .forEach{ movie in
                        realm.add(movie, update: .modified)
                    }
            }
        } catch {
            print("ERROR: \(error)")
        }
    }
}
