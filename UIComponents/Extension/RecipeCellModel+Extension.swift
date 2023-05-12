//
//  RecipeCellModel+Extension.swift
//  UIComponents
//
//  Created by İbrahim Kültepe on 11.05.2023.
//

public extension RecipeCellModel {
    
    convenience init(recipe: Items) {
        self.init(userNameAndSurname: "\(recipe.user.name ?? "İbrahim") \(recipe.user.surname ?? "Kültepe")",
                  userImageURL: recipe.user.userImage.url,
                  userRecipeAndFollowerCountText: "\(recipe.user.recipeCount) Tarif \(recipe.user.followedCount) Takipçi",
                  recipeTitle: recipe.title,
                  recipeCategory: recipe.category.name,
                  recipeImageURL: recipe.recipeImage.first?.url,
                  recipeCommentAndLikeCountText: "\(recipe.commentCount) Yorum \(recipe.likeCount) Beğeni")
    }
}
