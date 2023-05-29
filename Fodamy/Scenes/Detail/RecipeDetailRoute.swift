//
//  RecipeDetailRoute.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 26.05.2023.
//

protocol RecipeDetailRoute {
    func pushRecipeDetail()
}

extension RecipeDetailRoute where Self: RouterProtocol {
    
    func pushRecipeDetail() {
        let router = RecipeDetailRouter()
        let viewModel = RecipeDetailViewModel(router: router)
        let viewController = RecipeDetailViewController(viewModel: viewModel)
        
        let transition = PushTransition()
        router.viewController = viewController
        router.openTransition = transition
        
        open(viewController, transition: transition)
    }
}
