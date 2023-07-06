//
//  CommentSectionRoute.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 28.06.2023.
//

protocol CommentSectionRoute {
    func pushCommentSection(recipeId: Int)
}

extension CommentSectionRoute where Self: RouterProtocol {
    
    func pushCommentSection(recipeId: Int) {
        let router = CommentSectionRouter()
        let viewModel = CommentSectionViewModel(recipeId: recipeId, router: router)
        let viewController = CommentSectionViewController(viewModel: viewModel)
        
        let transition = PushTransition()
        router.viewController = viewController
        router.openTransition = transition
        
        open(viewController, transition: transition)
    }
}
