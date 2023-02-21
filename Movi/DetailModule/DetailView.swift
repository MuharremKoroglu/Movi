//
//  DetailView.swift
//  Movi
//
//  Created by Muharrem Köroğlu on 17.02.2023.
//

import Foundation
import UIKit
import SDWebImage


protocol AnyMovieDetailView {
    
    var presenter : AnyMovieDetailPresenter? {get set}
    
    func movieDetailUpdate (with singleMovie : SingleMovie)
    func movieDetailUpdate ()
}

class MovieDetailView : UIViewController, AnyMovieDetailView {
    
    var presenter: AnyMovieDetailPresenter?
    
    private let detailMoviePoster : UIImageView = {
        let detailMoviePoster = UIImageView()
        detailMoviePoster.sd_setImage(with: URL(string: ""))
        detailMoviePoster.contentMode = .scaleAspectFit
        detailMoviePoster.clipsToBounds = true
        return detailMoviePoster
    }()
    
    
    private let detailMovieTitle : UILabel = {
        let detailMovieTitle = UILabel()
        detailMovieTitle.text = ""
        detailMovieTitle.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        detailMovieTitle.textColor = .black
        detailMovieTitle.numberOfLines = 2
        detailMovieTitle.textAlignment = .center
        return detailMovieTitle
    }()
    
    private let detailMovieOverview : UILabel = {
        let detailMovieOverview = UILabel()
        detailMovieOverview.text = ""
        detailMovieOverview.font = UIFont.systemFont(ofSize: 15)
        detailMovieOverview.textColor = .black
        detailMovieOverview.numberOfLines = 0
        detailMovieOverview.lineBreakMode = .byWordWrapping
        detailMovieOverview.textAlignment = .center
        detailMovieOverview.sizeToFit()
        return detailMovieOverview
    }()
    
    private let detailMovieReleaseDate : UILabel = {
        let detailMovieReleaseDate = UILabel()
        detailMovieReleaseDate.text = ""
        detailMovieReleaseDate.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        detailMovieReleaseDate.textColor = .black
        detailMovieReleaseDate.textAlignment = .center
        return detailMovieReleaseDate
    }()
    
    private let detailIcon : UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(systemName: "star.fill")
        icon.tintColor = .systemYellow
        return icon
    }()
    
    private let detailMovieScore : UILabel = {
        let detailMovieScore = UILabel()
        detailMovieScore.text = ""
        detailMovieScore.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        detailMovieScore.textColor = .systemYellow
        detailMovieScore.textAlignment = .center
        return detailMovieScore
    }()
    
    private let detailMovieLanguage : UILabel = {
        let detailMovieLanguage = UILabel()
        detailMovieLanguage.text = ""
        detailMovieLanguage.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        detailMovieLanguage.textColor = .black
        detailMovieLanguage.numberOfLines = 0
        detailMovieLanguage.lineBreakMode = .byWordWrapping
        detailMovieLanguage.textAlignment = .center
        detailMovieLanguage.sizeToFit()
        return detailMovieLanguage
    }()
    
    private let detailMovieCountry : UILabel = {
        let detailMovieCountry = UILabel()
        detailMovieCountry.text = ""
        detailMovieCountry.font = UIFont.systemFont(ofSize: 15,weight: .bold)
        detailMovieCountry.textColor = .black
        detailMovieCountry.textAlignment = .center
        detailMovieCountry.numberOfLines = 0
        detailMovieCountry.lineBreakMode = .byWordWrapping
        detailMovieCountry.textAlignment = .center
        detailMovieCountry.sizeToFit()
        return detailMovieCountry
    }()
    
    private let detailMovieGenres : UILabel = {
        let detailMovieGenres = UILabel()
        detailMovieGenres.text = ""
        detailMovieGenres.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        detailMovieGenres.textColor = .black
        detailMovieGenres.numberOfLines = 0
        detailMovieGenres.lineBreakMode = .byWordWrapping
        detailMovieGenres.textAlignment = .center
        detailMovieGenres.sizeToFit()
        return detailMovieGenres
    }()
    
    private let detailMovieIndicator : UIActivityIndicatorView = {
       let detailMovieIndicator = UIActivityIndicatorView()
        detailMovieIndicator.style = .large
        detailMovieIndicator.color = .black
        detailMovieIndicator.isHidden = false
        return detailMovieIndicator
    }()
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        detailMoviePoster.frame = CGRect(x: view.frame.size.width / 2 - 100, y: view.frame.size.height / 2 - 370, width: 200, height: 250)
        detailMovieTitle.frame = CGRect(x: view.frame.size.width / 2 - 250, y: view.frame.size.height / 2 - 190, width: 500, height: 200)
        detailMovieOverview.frame = CGRect(x: view.frame.size.width / 2 - 190, y: view.frame.size.height / 2 - 80, width: view.frame.size.width - 10 , height: 170)
        detailIcon.frame = CGRect(x: view.frame.size.width / 2 - 55, y: view.frame.size.height / 2 + 90, width: 35, height: 30)
        detailMovieScore.frame = CGRect(x: view.frame.size.width / 2 - 17, y: view.frame.size.height / 2 + 95, width: 70, height: 20)
        detailMovieReleaseDate.frame = CGRect(x: view.frame.size.width / 2 - 125, y: view.frame.size.height / 2 + 150, width: 250, height: 20)
        detailMovieLanguage.frame = CGRect(x: view.frame.size.width / 2 - 150, y: view.frame.size.height / 2 + 190, width: 300, height: 50)
        detailMovieCountry.frame = CGRect(x: view.frame.size.width / 2 - 150, y: view.frame.size.height / 2 + 250, width: 300, height: 50)
        detailMovieGenres.frame = CGRect(x: view.frame.size.width / 2 - 125, y: view.frame.size.height / 2 + 300, width: 250, height: 50)
        detailMovieIndicator.frame = CGRect(x: view.frame.width / 2 - 25, y: view.frame.height / 2 - 25, width: 50, height: 50)

    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.addSubview(detailMoviePoster)
        view.addSubview(detailMovieTitle)
        view.addSubview(detailMovieOverview)
        view.addSubview(detailMovieReleaseDate)
        view.addSubview(detailIcon)
        view.addSubview(detailMovieScore)
        view.addSubview(detailMovieLanguage)
        view.addSubview(detailMovieCountry)
        view.addSubview(detailMovieGenres)
        view.addSubview(detailMovieIndicator)
        view.backgroundColor = .systemGray

    }
    
    func movieDetailUpdate(with singleMovie: SingleMovie) {
        
        DispatchQueue.main.async {
            self.detailMovieTitle.text = singleMovie.title
            self.detailMoviePoster.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/original\(singleMovie.poster_path)"))
            self.detailMovieOverview.text = singleMovie.overview
            self.detailMovieReleaseDate.text = "Release Date : \(singleMovie.formatted_release_date)"
            self.detailMovieScore.text = "\(String(format: "%.1f", singleMovie.vote_average)) / 10"
            if singleMovie.spoken_languages.count == 0{
                self.detailMovieLanguage.text = "Language : English"
            }else {
                var languageText = "Spoken Languages : "
                for i in 0 ... singleMovie.spoken_languages.count - 1 {
                    let languageName = singleMovie.spoken_languages[i].english_name
                    languageText += "\(languageName), "
                }
                languageText = String(languageText.dropLast(2))
                self.detailMovieLanguage.text = languageText
            }
            if singleMovie.production_countries.count == 0{
                self.detailMovieCountry.text = "Country : United States of America"
            }else {
                var countryText = "Production Countries : "
                for i in 0 ... singleMovie.production_countries.count - 1 {
                    let countryName = singleMovie.production_countries[i].name
                    countryText += "\(countryName), "
                }
                countryText = String(countryText.dropLast(2))
                self.detailMovieCountry.text = countryText
            }
            var genresText = "Genres: "
            for i in 0 ... singleMovie.genres.count - 1 {
                let genreName = singleMovie.genres[i].name
                genresText += "\(genreName), "
            }
            genresText = String(genresText.dropLast(2))
            self.detailMovieGenres.text = genresText
            self.detailMovieIndicator.isHidden = true
            self.detailMovieIndicator.stopAnimating()
        }

    }
    
    func movieDetailUpdate() {
        DispatchQueue.main.async {
            self.detailMovieIndicator.isHidden = false
            self.detailIcon.isHidden = true
            self.detailMovieIndicator.startAnimating()
        }
    }
    
    
    
}
