//
//  RecipeRoute.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 2.05.2023.
//

protocol RecipeRoute {
    func pushRecipes()
}

extension RecipeRoute where Self: RouterProtocol {
    
    func pushRecipes() {
        let router = RecipesRouter()
        let viewModel = RecipesViewModel(recipeListType: .recentlyAdded, router: router)
        let viewController = RecipesViewController(viewModel: viewModel)
        let navController = UINavigationController(rootViewController: viewController)
        
        let transition = PushTransition()
        router.viewController = viewController
        router.openTransition = transition
        
        open(navController, transition: transition)
    }
}
