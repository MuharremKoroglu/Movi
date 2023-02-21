//
//  Presenter.swift
//  Movi
//
//  Created by Muharrem Köroğlu on 13.02.2023.
//

import Foundation

enum ErrorType : Error {
    
    case NetworkError
    case ParseError
    
}
protocol AnyPresenter {
    
    var router : AnyRouter? {get set}
    var interactor : AnyInteractor? {get set}
    var view : AnyView? {get set}
    
    func interactorDidDownloadMovies (result : Result<PopularMovies, Error>)
}

class MoviePresenter : AnyPresenter {

    var router: AnyRouter?
    
    var interactor: AnyInteractor? {
        didSet {
            interactor?.getMovies()
        }
    }
    
    var view: AnyView?
    
    func interactorDidDownloadMovies(result: Result<PopularMovies, Error>) {
        switch result {
        case .success(let movies) :
            view?.update(with: movies)
        case .failure(_) :
            view?.update()
        }
    }
}
