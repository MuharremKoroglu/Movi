//
//  DetailPresenter.swift
//  Movi
//
//  Created by Muharrem Köroğlu on 17.02.2023.
//

import Foundation

enum MovieDetailError : Error {
    case NetworkError
    case ParseError
}

protocol AnyMovieDetailPresenter {
    
    var router : AnyMovieDetailRouter? {get set}
    var interactor : AnyMovieDetailInteractor? {get set}
    var view : AnyMovieDetailView? {get set}
    
    func didDownloadInteractorMovieDetails (result : Result<SingleMovie, Error>)
}

class MovieDetailPresenter : AnyMovieDetailPresenter {
    
    var router: AnyMovieDetailRouter?
    
    var interactor: AnyMovieDetailInteractor? {
        didSet {
            self.interactor?.getMovieDetail()
        }
    }
    
    var view: AnyMovieDetailView?
    
    func didDownloadInteractorMovieDetails(result: Result<SingleMovie, Error>) {
        switch result {
        case .success(let movieDetail) :
            view?.movieDetailUpdate(with: movieDetail)
        case .failure(_):
            view?.movieDetailUpdate()
        }
    }
    
    
}
