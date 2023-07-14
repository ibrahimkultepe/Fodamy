//
//  EditRecipeCommentRequest.swift
//  DataProvider
//
//  Created by İbrahim Kültepe on 12.07.2023.
//

public struct EditRecipeCommentRequest: APIDecodableResponseRequest {
    
    public typealias ResponseType = SuccessResponse
    
    public var path: String = ""
    public let method: RequestMethod = .put
    public var parameters: RequestParameters = [:]
    
    public init(recipeId: Int, commentId: Int, commentText: String) {
        self.path = "recipe/\(recipeId)/comment/\(commentId)"
        self.parameters["text"] = commentText
    }
}
