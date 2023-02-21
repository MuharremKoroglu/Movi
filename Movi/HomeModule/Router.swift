//
//  Router.swift
//  Movi
//
//  Created by Muharrem Köroğlu on 13.02.2023.
//

import Foundation
import UIKit

typealias EntryPoint = UIViewController & AnyView

protocol AnyRouter {
    var entryPoint : EntryPoint? {get}
    static func startTheApp () -> AnyRouter
}

class MovieRouter : AnyRouter {
    
    var entryPoint: EntryPoint?
    
    static func startTheApp() -> AnyRouter {
        let router = MovieRouter()
        
        var view : AnyView = MovieView()
        var presenter : AnyPresenter = MoviePresenter()
        var interactor : AnyInteractor = MovieInteractor()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        
        router.entryPoint = view as? EntryPoint
        
        return router
    }
}
