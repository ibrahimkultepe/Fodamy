//
//  RecipeLikeRequest.swift
//  DataProvider
//
//  Created by İbrahim Kültepe on 22.06.2023.
//

public struct RecipeLikeRequest: APIDecodableResponseRequest {
    
    public typealias ResponseType = SuccessResponse
    
    public var path: String = ""
    public var method: RequestMethod = .post
    
    public init(recipeId: Int, likeType: LikeType) {
        self.path = "recipe/\(recipeId)/like"
        switch likeType {
        case .like:
            method = .post
        case .unlike:
            method = .delete
        }
    }
    
    public enum LikeType {
        case like
        case unlike
    }
}
