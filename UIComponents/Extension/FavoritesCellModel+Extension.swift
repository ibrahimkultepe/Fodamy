//
//  FavoritesCellModel+Extension.swift
//  UIComponents
//
//  Created by İbrahim Kültepe on 23.05.2023.
//

public extension FavoritesCellModel {
    
    convenience init(category: MainCategory) {
        let cellItems = category.recipes?.map({ CategoryRecipesCellModel(recipe: $0) })
        self.init(categoryImageURL: category.recipes?.first?.category.image?.url,
                  recipeCategory: category.name,
                  cellItems: cellItems,
                  categoryId: category.id)
    }
}
