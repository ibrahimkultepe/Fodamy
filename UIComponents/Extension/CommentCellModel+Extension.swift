//
//  CommentCellModel+Extension.swift
//  UIComponents
//
//  Created by İbrahim Kültepe on 6.06.2023.
//

public extension CommentCellModel {
    
    convenience init(recipeComment: RecipeComment) {
        self.init(userNameAndSurname: "\(recipeComment.user.name ?? "") \(recipeComment.user.surname ?? "")",
                  userImageURL: recipeComment.user.image?.url,
                  userRecipeAndFollowerCountText: "\(recipeComment.user.recipeCount) Tarif \(recipeComment.user.followedCount) Takipçi",
                  difference: recipeComment.difference,
                  commentText: recipeComment.text)
    }
}
