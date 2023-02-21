//
//  Entity.swift
//  Movi
//
//  Created by Muharrem Köroğlu on 13.02.2023.
//

import Foundation

struct PopularMovies : Decodable {
    var results : [Results]
}

struct Results : Decodable {
    var title : String
    var poster_path : String
    var vote_average : Double
    var id : Int
    private var release_date : String
    var formatted_release_date : String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: self.release_date) {
            let originalFormatter = DateFormatter()
            originalFormatter.dateFormat = "dd-MM-yyyy"
            return originalFormatter.string(from: date)
        } else {
            return self.release_date
        }
     }
}

