//
//  User.swift
//  DataProvider
//
//  Created by İbrahim Kültepe on 11.05.2023.
//

public struct User: Decodable {
    public let name: String?
    public let surname: String?
    public let followedCount: Int
    public let recipeCount: Int
    public let image: Image?
    public let username: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case surname
        case followedCount = "followed_count"
        case recipeCount = "recipe_count"
        case image
        case username
    }
}
