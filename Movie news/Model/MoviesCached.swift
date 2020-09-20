//
//  MoviesCached.swift
//  Movie news
//
//  Created by Beka Zhapparkulov on 9/18/20.
//  Copyright © 2020 Kazybek. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
class MoviesCached: Object {
    dynamic var voteCount: Int = 0
    dynamic var posterPath = ""
    dynamic var id: Int = 0
    dynamic var backdropPath = ""
    dynamic var originalLanguage = ""
    dynamic var title = ""
    dynamic var voteAverage: Double = 0.0
    dynamic var overview = ""
    dynamic var releaseDate = ""
    dynamic var favorites = false
    
    override class func primaryKey() -> String? {
        return "id"
    }

    convenience init(movie: Films){
        self.init()
        voteCount = movie.voteCount ?? 0
        posterPath = movie.posterPath ?? ""
        id = movie.id ?? 0
        backdropPath = movie.backdropPath ?? ""
        originalLanguage = movie.originalLanguage ?? ""
        title = movie.title ?? ""
        voteAverage = movie.voteAverage ?? 0.0
        overview = movie.overview ?? ""
        releaseDate = movie.releaseDate ?? ""
    }
}
