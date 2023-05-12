//
//  RecipeCellModel.swift
//  UIComponents
//
//  Created by İbrahim Kültepe on 10.05.2023.
//

import UIKit

public protocol RecipeCellModelDataSource: AnyObject {
    var userNameAndSurname: String? { get }
    var userImageURL: String? { get }
    var userRecipeAndFollowerCountText: String? { get }
    var recipeTitle: String? { get }
    var recipeCategory: String? { get }
    var recipeImageURL: String? { get }
    var recipeCommentAndLikeCountText: String? { get }
}

public protocol RecipeCellModelEventSource: AnyObject {
    
}

public protocol RecipeCellModelProtocol: RecipeCellModelDataSource, RecipeCellModelEventSource {
    
}

public final class RecipeCellModel: RecipeCellModelProtocol {
    public var userNameAndSurname: String?
    public var userImageURL: String?
    public var userRecipeAndFollowerCountText: String?
    public var recipeTitle: String?
    public var recipeCategory: String?
    public var recipeImageURL: String?
    public var recipeCommentAndLikeCountText: String?
    
    public init(userNameAndSurname: String?,
                userImageURL: String?,
                userRecipeAndFollowerCountText: String?,
                recipeTitle: String?,
                recipeCategory: String?,
                recipeImageURL: String?,
                recipeCommentAndLikeCountText: String?) {
        self.userNameAndSurname = userNameAndSurname
        self.userImageURL = userImageURL
        self.userRecipeAndFollowerCountText = userRecipeAndFollowerCountText
        self.recipeTitle = recipeTitle
        self.recipeCategory = recipeCategory
        self.recipeImageURL = recipeImageURL
        self.recipeCommentAndLikeCountText = recipeCommentAndLikeCountText
    }
}
