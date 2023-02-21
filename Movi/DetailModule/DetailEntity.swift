//
//  DetailEntity.swift
//  Movi
//
//  Created by Muharrem Köroğlu on 17.02.2023.
//

import Foundation

struct SingleMovie : Decodable {
    var title : String
    var poster_path : String
    var vote_average : Double
    var overview : String
    var spoken_languages : [SpokenLanguages]
    var production_countries : [ProductionCountries]
    var genres : [Genres]
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

struct SpokenLanguages : Decodable {
    var english_name : String
}

struct ProductionCountries : Decodable {
    var name : String
}

struct Genres : Decodable {
    var name : String
}
