//
//  RecipeRoute.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 2.05.2023.
//

protocol RecipeRoute {
    func pushRecipes(categoryId: Int)
}

extension RecipeRoute where Self: RouterProtocol {
    
    func pushRecipes(categoryId: Int) {
        let router = RecipesRouter()
        let viewModel = RecipesViewModel(recipeListType: .categoryRecipes(categoryId: categoryId), router: router)
        let viewController = RecipesViewController(viewModel: viewModel)
        
        let transition = PushTransition()
        router.viewController = viewController
        router.openTransition = transition
        
        open(viewController, transition: transition)
    }
}
