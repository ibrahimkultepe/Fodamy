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
    public var parameters: RequestParameters = [:]
    
    public init(recipeId: Int, page: Int? = 1) {
        self.path = "recipe/\(recipeId)/comment"
        self.parameters["page"] = page
    }
}
