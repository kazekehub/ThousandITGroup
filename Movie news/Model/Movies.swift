//
//  Movies.swift
//  Movie news
//
//  Created by Beka Zhapparkulov on 9/18/20.
//  Copyright © 2020 Kazybek. All rights reserved.
//

import Foundation

struct Movies: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case results
    }
    let results: [Films]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.results = try container.decode([Films].self, forKey: .results)
    }
}

struct Films: Decodable {
    var popularity: Double?
    var voteCount: Int?
    var posterPath: String?
    var id: Int?
    var backdropPath: String?
    var originalLanguage: String?
    var title: String?
    var voteAverage: Double?
    var overview: String?
    var releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case popularity
        case voteCount = "vote_count"
        case posterPath = "poster_path"
        case id
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case title
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.popularity = try? container.decode(Double.self, forKey: .popularity)
        self.voteCount = try? container.decode(Int.self, forKey: .voteCount)
        self.posterPath = try? container.decode(String.self, forKey: .posterPath)
        self.id = try? container.decode(Int.self, forKey: .id)
        self.backdropPath = try? container.decode(String.self, forKey: .backdropPath)
        self.originalLanguage = try? container.decode(String.self, forKey: .originalLanguage)
        self.title = try? container.decode(String.self, forKey: .title)
        self.voteAverage = try? container.decode(Double.self, forKey: .voteAverage)
        self.overview = try? container.decode(String.self, forKey: .overview)
        self.releaseDate = try? container.decode(String.self, forKey: .releaseDate)
    }
    
    init(moviesCached:MoviesCached){
        voteCount = moviesCached.voteCount
        posterPath = moviesCached.posterPath
        id = moviesCached.id
        backdropPath = moviesCached.backdropPath
        originalLanguage = moviesCached.originalLanguage
        title = moviesCached.title
        voteAverage = moviesCached.voteAverage
        overview = moviesCached.overview
        releaseDate = moviesCached.releaseDate
    }
}
