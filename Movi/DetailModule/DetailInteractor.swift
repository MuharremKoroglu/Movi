//
//  DetailInteractor.swift
//  Movi
//
//  Created by Muharrem Köroğlu on 17.02.2023.
//

import Foundation


protocol AnyMovieDetailInteractor {
    var presenter : AnyMovieDetailPresenter? {get set}
    func getMovieDetail ()
}

class MovieDetailInteractor : AnyMovieDetailInteractor {
    var presenter: AnyMovieDetailPresenter?
    
    func getMovieDetail() {

        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(String(MovieIdSingleton.sharedInstance.movieId))?api_key=ca778a79ee00b9032923844aaa169890") else {
            return print("URL is not correct!")
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            guard let data = data , error == nil else {
                self?.presenter?.didDownloadInteractorMovieDetails(result: .failure(MovieDetailError.NetworkError ))
                return
            }
            
            do {
                let movieDetail =  try JSONDecoder().decode(SingleMovie.self, from: data)
                self?.presenter?.didDownloadInteractorMovieDetails(result: .success(movieDetail))
            }catch{
                self?.presenter?.didDownloadInteractorMovieDetails(result: .failure(MovieDetailError.ParseError))
            }
        }
        task.resume()
    }
 
}
