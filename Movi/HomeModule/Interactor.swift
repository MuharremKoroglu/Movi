//
//  Interactor.swift
//  Movi
//
//  Created by Muharrem Köroğlu on 13.02.2023.
//

import Foundation


protocol AnyInteractor {
    
    var presenter : AnyPresenter? {get set}
    
    func getMovies ()
}

class MovieInteractor : AnyInteractor {

    var presenter: AnyPresenter?
    
    func getMovies() {
        
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=ca778a79ee00b9032923844aaa169890") else {
            return print("URL is not correct!")
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            guard let data = data , error == nil else{
                self?.presenter?.interactorDidDownloadMovies(result: .failure(ErrorType.NetworkError))
                return
            }
            
            do{
                let movies = try JSONDecoder().decode(PopularMovies.self, from: data)
                self?.presenter?.interactorDidDownloadMovies(result: .success(movies))
            }catch{
                self?.presenter?.interactorDidDownloadMovies(result: .failure(ErrorType.ParseError))
            }
            
        }
        
        task.resume()
        
    }
    
    
}
