//
//  DetailRouter.swift
//  Movi
//
//  Created by Muharrem Köroğlu on 17.02.2023.
//

import Foundation
import UIKit

typealias MovieDetailEntryPoint = UIViewController & AnyMovieDetailView

protocol AnyMovieDetailRouter {
    var movieDetailEntryPoint : MovieDetailEntryPoint? {get set}
    func startMovieDetail () -> AnyMovieDetailRouter
}

class MovieDetailRouter : AnyMovieDetailRouter {

    var movieDetailEntryPoint: MovieDetailEntryPoint?
    
    func startMovieDetail() -> AnyMovieDetailRouter {
        
        let movieDetailRouter = MovieDetailRouter()
        
        var movieDetailView : AnyMovieDetailView = MovieDetailView()
        var movieDetailPresenter : AnyMovieDetailPresenter = MovieDetailPresenter()
        var movieDetailInteractor : AnyMovieDetailInteractor = MovieDetailInteractor()

        movieDetailView.presenter = movieDetailPresenter
        
        movieDetailPresenter.view = movieDetailView
        movieDetailPresenter.router = movieDetailRouter
        movieDetailPresenter.interactor = movieDetailInteractor
        
        movieDetailInteractor.presenter = movieDetailPresenter
        
        movieDetailRouter.movieDetailEntryPoint = movieDetailView as? MovieDetailEntryPoint
        

        return movieDetailRouter
    }

}
 

