//
//  TabBarRoute.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 20.04.2023.
//

protocol TabBarRoute {
    func placeOnWindowTabBar()
}

extension TabBarRoute where Self: RouterProtocol {
    
    func placeOnWindowTabBar() {
        let viewController = TabBarViewController()
        let transition = PlaceOnWindowTransition()
        open(viewController, transition: transition)
    }
}
