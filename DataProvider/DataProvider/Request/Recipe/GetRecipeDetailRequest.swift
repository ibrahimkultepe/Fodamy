//
//  GetRecipeDetailRequest.swift
//  DataProvider
//
//  Created by İbrahim Kültepe on 29.05.2023.
//

public struct GetRecipeDetailRequest: APIDecodableResponseRequest {
    
    public typealias ResponseType = RecipeDetail
    
    public var path: String = ""
    public let method: RequestMethod = .get
    
    
    public init(recipeId: Int) {
        self.path = "recipe/\(recipeId)"
    }
}
