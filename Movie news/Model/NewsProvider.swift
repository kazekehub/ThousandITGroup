//
//  NewsProvider.swift
//  Movie news
//
//  Created by Beka Zhapparkulov on 9/18/20.
//  Copyright © 2020 Kazybek. All rights reserved.
//

import Foundation
import Alamofire

protocol MovieNewsDelegate {
    func provideMovie(movies: Movies)
}

class NewsProvider: MovieNewsProtocol {
    var delegate: MovieNewsDelegate?
    init(delegate: MovieNewsDelegate) {
      self.delegate = delegate
    }
    
    let apiKey = "api_key=1b3d4b120dcfe12e4978eb05f1381a8d&language=ru"
    let mainURL = "https://api.themoviedb.org/3/movie/"
    
    func getMovie(_ category: String) {
        let url = "\(mainURL)\(category)\(apiKey)"
        AF.request(url, method: .get).responseJSON { response in
            switch response.result {
                case .success:
                    guard let data = response.data else {return}
                    let parsedResult: Movies = try! JSONDecoder().decode(Movies.self, from: data)
                    self.delegate?.provideMovie(movies: parsedResult)
                case .failure(let error):
                    print(error)
            }
        }
    }
}
