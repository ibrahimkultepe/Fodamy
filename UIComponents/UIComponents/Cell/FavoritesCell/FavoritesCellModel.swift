//
//  FavoritesCellModel.swift
//  UIComponents
//
//  Created by İbrahim Kültepe on 22.05.2023.
//

import UIKit

public protocol FavoritesCellModelDataSource: AnyObject {
    var categoryImageURL: String? { get }
    var recipeCategory: String? { get }
    var cellItems: [CategoryRecipesCellProtocol]? { get }
    var numberOfItems: Int? { get }
    var didSelectRecipeDetail: IntClosure? { get set }
    var seeAllButtonTapped: IntClosure? { get set }
    var categoryId: Int { get }
    func cellItemForAt(indexPath: IndexPath) -> CategoryRecipesCellProtocol?
}

public protocol FavoritesCellModelEventSource: AnyObject {
}

public protocol FavoritesCellModelProtocol: FavoritesCellModelDataSource, FavoritesCellModelEventSource {
}

public final class FavoritesCellModel: FavoritesCellModelProtocol {
    
    public func cellItemForAt(indexPath: IndexPath) -> CategoryRecipesCellProtocol? {
        return cellItems?[indexPath.row]
    }
    
    public var numberOfItems: Int? {
        return cellItems?.count
    }
    
    public var seeAllButtonTapped: IntClosure?
    public var didSelectRecipeDetail: IntClosure?
    public var categoryId: Int
    public var categoryImageURL: String?
    public var recipeCategory: String?
    public var cellItems: [CategoryRecipesCellProtocol]?
    
    public init(categoryImageURL: String?,
                recipeCategory: String?,
                cellItems: [CategoryRecipesCellProtocol]?,
                categoryId: Int) {
        self.categoryImageURL = categoryImageURL
        self.recipeCategory = recipeCategory
        self.cellItems = cellItems
        self.categoryId = categoryId
    }
}
