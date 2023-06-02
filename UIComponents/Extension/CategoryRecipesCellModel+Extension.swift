//
//  CategoryRecipesCellModel+Extension.swift
//  UIComponents
//
//  Created by İbrahim Kültepe on 24.05.2023.
//

public extension CategoryRecipesCellModel {
    
    convenience init(recipe: Recipe) {
        self.init(recipeId: recipe.recipeId,
                  recipeImageURL: recipe.images.first?.url,
                  recipeTitle: recipe.title,
                  recipeCommentAndLikeCountText: "\(recipe.commentCount) Yorum \(recipe.likeCount) Beğeni")
    }
}
