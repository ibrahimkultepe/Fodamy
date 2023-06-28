//
//  UserFollowRequest.swift
//  DataProvider
//
//  Created by İbrahim Kültepe on 21.06.2023.
//

public struct UserFollowRequest: APIDecodableResponseRequest {
    
    public typealias ResponseType = SuccessResponse
    
    public var path: String = ""
    public var method: RequestMethod = .post
    
    public init(followUserId: Int, followStatus: FollowStatus) {
        self.path = "user/\(followUserId)/following"
        switch followStatus {
        case .follow:
            method = .post
        case .unfollow:
            method = .delete
        }
    }
    
    public enum FollowStatus {
        case follow
        case unfollow
    }
}
