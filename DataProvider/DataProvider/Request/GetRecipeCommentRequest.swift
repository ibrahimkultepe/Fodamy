//
//  GetRecipeCommentRequest.swift
//  DataProvider
//
//  Created by İbrahim Kültepe on 6.06.2023.
//

public struct GetRecipeCommentRequest: APIDecodableResponseRequest {
    
    public typealias ResponseType = RecipeData<[RecipeComment]>
    
    public var path: String = ""
    public let method: RequestMethod = .get
    
    public init(recipeId: Int) {
        self.path = "recipe/\(recipeId)/comment"
    }
}
