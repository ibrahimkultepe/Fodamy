//
//  TabBarViewController.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 17.04.2023.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .appRed
        let homeViewController = addHomeViewController()
        let favoritesViewController = addFavoritesViewController()
        viewControllers = [homeViewController, favoritesViewController]
    }
    
    private func addHomeViewController() -> UIViewController {
        let homeRouter = HomeRouter()
        let homeViewModel = HomeViewModel(router: homeRouter)
        let homeViewController = HomeViewController(viewModel: homeViewModel)
        homeViewController.tabBarItem.image = .icHome
        return homeViewController
    }
    
    private func addFavoritesViewController() -> UIViewController {
        let favoritesRouter = FavoritesRouter()
        let favoritesViewModel = FavoritesViewModel(router: favoritesRouter)
        let favoritesViewController = FavoritesViewController(viewModel: favoritesViewModel)
        favoritesViewController.tabBarItem.image = .icHeart
        return favoritesViewController
    }
}
