//
//  RecipeCellModel+Extension.swift
//  UIComponents
//
//  Created by İbrahim Kültepe on 11.05.2023.
//

public extension RecipeCellModel {
    
    convenience init(recipe: Recipe) {
        self.init(userNameAndSurname: "\(recipe.user.name ?? "") \(recipe.user.surname ?? "")",
                  userImageURL: recipe.user.image?.url,
                  userRecipeAndFollowerCountText: "\(recipe.user.recipeCount) Tarif \(recipe.user.followedCount) Takipçi",
                  recipeTitle: recipe.title,
                  recipeCategory: recipe.category.name,
                  recipeImageURL: recipe.images.first?.url,
                  recipeCommentAndLikeCountText: "\(recipe.commentCount) Yorum \(recipe.likeCount) Beğeni")
    }
}
