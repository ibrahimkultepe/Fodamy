//
//  WalkthroughRoute.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 8.03.2023.
//

import UIKit

protocol WalkthroughRoute {
    func placeOnWindowHome()
}

extension WalkthroughRoute where Self: RouterProtocol {
    
    func placeOnWindowHome() {
        let router = WalkthroughRouter()
        let viewModel = WalkthroughViewModel(router: router)
        let viewController = WalkthroughViewController(viewModel: viewModel)
        let navController = UINavigationController(rootViewController: viewController)
        
        let transition = PlaceOnWindowTransition()
        router.viewController = viewController
        router.openTransition = transition
        
        open(navController, transition: transition)
    }
}
