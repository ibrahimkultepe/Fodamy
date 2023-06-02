//
//  Items.swift
//  DataProvider
//
//  Created by İbrahim Kültepe on 11.05.2023.
//

public struct Recipe: Decodable {
    public let recipeId: Int
    public let title: String?
    public let isEditorChoice: Bool
    public let likeCount: Int
    public let commentCount: Int
    public let user: User
    public let category: RecipeCategory
    public let images: [Image]
    
    enum CodingKeys: String, CodingKey {
        case recipeId = "id"
        case title
        case isEditorChoice = "is_editor_choice"
        case likeCount = "like_count"
        case commentCount = "comment_count"
        case user
        case category
        case images
    }
}
