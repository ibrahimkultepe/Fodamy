//
//  Items.swift
//  DataProvider
//
//  Created by İbrahim Kültepe on 11.05.2023.
//

public struct Items: Decodable {
    public let title: String?
    public let isEditorChoice: Bool?
    public let likeCount: Int
    public let commentCount: Int
    public let user: User
    public let category: RecipeCategory
    public let recipeImage: [RecipeImage]
    
    enum CodingKeys: String, CodingKey {
        case title
        case isEditorChoice = "is_editor_choice"
        case likeCount = "like_count"
        case commentCount = "comment_count"
        case user
        case category
        case recipeImage = "images"
    }
}
