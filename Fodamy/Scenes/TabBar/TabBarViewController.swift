//
//  TabBarViewController.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 20.04.2023.
//

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .appRed
        let homeViewController = addHomeViewController()
        let favoritesViewController = addFavoritesViewController()
        viewControllers = [homeViewController, favoritesViewController]
    }
    
    private func addHomeViewController() -> UINavigationController {
        let homeRouter = HomeRouter()
        let homeViewModel = HomeViewModel(router: homeRouter)
        let homeViewController = HomeViewController(viewModel: homeViewModel)
        let navController = UINavigationController(rootViewController: homeViewController)
        homeRouter.viewController = homeViewController
        homeViewController.tabBarItem.image = .icHome
        return navController
    }
    
    private func addFavoritesViewController() -> UINavigationController {
        let favoritesRouter = FavoritesRouter()
        let favoritesViewModel = FavoritesViewModel(router: favoritesRouter)
        let favoritesViewController = FavoritesViewController(viewModel: favoritesViewModel)
        let navController = UINavigationController(rootViewController: favoritesViewController)
        favoritesRouter.viewController = favoritesViewController
        favoritesViewController.tabBarItem.image = .icHeart
        return navController
    }
}
