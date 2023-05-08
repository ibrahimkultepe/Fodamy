//
//  RecipeRoute.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 2.05.2023.
//

protocol RecipeRoute {
    func placeOnWindowRecipes()
}

extension RecipeRoute where Self: RouterProtocol {
    
    func placeOnWindowRecipes() {
        let router = RecipesRouter()
        let viewModel = RecipesViewModel(router: router)
        let viewController = RecipesViewController(viewModel: viewModel)
        let navController = UINavigationController(rootViewController: viewController)
        
        let transition = PlaceOnWindowTransition()
        router.viewController = viewController
        router.openTransition = transition
        
        open(navController, transition: transition)
    }
}
