//
//  MovieIdSingleton.swift
//  Movi
//
//  Created by Muharrem Köroğlu on 17.02.2023.
//

import Foundation


class MovieIdSingleton {
    
    static let sharedInstance = MovieIdSingleton()
    
    var movieId = Int()
    
    private init() {}
    
}
