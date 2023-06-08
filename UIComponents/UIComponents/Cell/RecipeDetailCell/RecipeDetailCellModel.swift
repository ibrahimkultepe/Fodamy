//
//  RecipeDetailCellModel.swift
//  UIComponents
//
//  Created by İbrahim Kültepe on 29.05.2023.
//

import UIKit

public protocol RecipeDetailCellModelDataSource: AnyObject {
    var recipeImageURL: String? { get }
}

public protocol RecipeDetailCellModelEventSource: AnyObject {
}

public protocol RecipeDetailCellModelProtocol: RecipeDetailCellModelDataSource, RecipeDetailCellModelEventSource {
}

public final class RecipeDetailCellModel: RecipeDetailCellModelProtocol {
    
    public var recipeImageURL: String?
    
    public init(recipeImageURL: String?) {
        self.recipeImageURL = recipeImageURL
    }
}
