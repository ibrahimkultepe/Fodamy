//
//  FavoritesRoute.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 20.04.2023.
//

protocol FavoritesRoute {
    func placeOnWindowFavorites()
}

extension FavoritesRoute where Self: RouterProtocol {
    
    func placeOnWindowFavorites() {
        let router = FavoritesRouter()
        let viewModel = FavoritesViewModel(router: router)
        let viewController = FavoritesViewController(viewModel: viewModel)
        
        let transition = ModalTransition()
        router.viewController = viewController
        router.openTransition = transition
        
        open(viewController, transition: transition)
    }
}
