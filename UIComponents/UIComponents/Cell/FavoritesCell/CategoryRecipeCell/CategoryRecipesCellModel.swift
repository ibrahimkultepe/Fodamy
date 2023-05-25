//
//  CategoryRecipesCell.swift
//  UIComponents
//
//  Created by İbrahim Kültepe on 23.05.2023.
//

//
//  FavoritesCellModel.swift
//  UIComponents
//
//  Created by İbrahim Kültepe on 22.05.2023.
//

import UIKit

public protocol CategoryRecipesCellModelDataSource: AnyObject {
    var recipeImageURL: String? { get }
    var recipeTitle: String? { get }
    var recipeCommentAndLikeCountText: String? { get }
}

public protocol CategoryRecipesCellModelEventSource: AnyObject {
}

public protocol CategoryRecipesCellProtocol: CategoryRecipesCellModelDataSource, CategoryRecipesCellModelEventSource {
}

public final class CategoryRecipesCellModel: CategoryRecipesCellProtocol {
    
    public var recipeImageURL: String?
    public var recipeTitle: String?
    public var recipeCommentAndLikeCountText: String?
    
    public init(recipeImageURL: String?,
                recipeTitle: String?,
                recipeCommentAndLikeCountText: String?) {
        self.recipeImageURL = recipeImageURL
        self.recipeTitle = recipeTitle
        self.recipeCommentAndLikeCountText = recipeCommentAndLikeCountText
    }
}
