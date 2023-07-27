//
//  User.swift
//  DataProvider
//
//  Created by İbrahim Kültepe on 11.05.2023.
//

public struct User: Decodable {
    public let followedCount: Int
    public let recipeCount: Int
    public let image: Image?
    public let username: String?
    public let isFollowing: Bool
    public let id: Int
    
    enum CodingKeys: String, CodingKey {
        case followedCount = "followed_count"
        case recipeCount = "recipe_count"
        case image
        case username
        case isFollowing = "is_following"
        case id
    }
}
