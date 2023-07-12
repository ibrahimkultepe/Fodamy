//
//  DeleteRecipeCommentRequest.swift
//  DataProvider
//
//  Created by İbrahim Kültepe on 7.07.2023.
//

public struct DeleteRecipeCommentRequest: APIDecodableResponseRequest {
    
    public typealias ResponseType = SuccessResponse

    public var path: String = ""
    public let method: RequestMethod = .delete
    
    public init(recipeId: Int, commentId: Int) {
        self.path = "recipe/\(recipeId)/comment/\(commentId)"
    }
}
