//
//  CommentCellModel+Extension.swift
//  UIComponents
//
//  Created by İbrahim Kültepe on 6.06.2023.
//

import MobilliumUserDefaults

public extension CommentCellModel {
    
    convenience init(recipeComment: RecipeComment) {
        let isOwner: Bool
        isOwner = recipeComment.user.id == DefaultsKey.userId.value
        
        self.init(userNameAndSurname: recipeComment.user.username,
                  userImageURL: recipeComment.user.image?.url,
                  userRecipeAndFollowerCountText: "\(recipeComment.user.recipeCount) Tarif \(recipeComment.user.followedCount) Takipçi",
                  difference: recipeComment.difference,
                  commentText: recipeComment.text,
                  commentId: recipeComment.id,
                  isOwner: isOwner,
                  userId: recipeComment.user.id)
    }
}
