//
//  PostRecipeCommentRequest.swift
//  DataProvider
//
//  Created by İbrahim Kültepe on 3.07.2023.
//

public struct PostRecipeCommentRequest: APIDecodableResponseRequest {
    
    public typealias ResponseType = RecipeComment

    public var path: String = ""
    public let method: RequestMethod = .post
    public var parameters: RequestParameters = [:]
    
    public init(recipeId: Int, commentText: String) {
        self.path = "recipe/\(recipeId)/comment"
        self.parameters["text"] = commentText
    }
}
