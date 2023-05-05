//
//  HomeRoute.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 4.05.2023.
//

protocol HomeRoute {
    func placeOnWindowWalkthrough()
}

extension HomeRoute where Self: RouterProtocol {
    
    func placeOnWindowWalkthrough() {
        let router = HomeRouter()
        let viewModel = HomeViewModel(router: router)
        let viewController = HomeViewController(viewModel: viewModel)
        let navController = MainNavigationController(rootViewController: viewController)
        
        let transition = PlaceOnWindowTransition()
        router.viewController = viewController
        router.openTransition = transition
        
        open(navController, transition: transition)
    }
}
