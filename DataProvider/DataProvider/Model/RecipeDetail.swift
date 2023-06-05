//
//  RecipeDetail.swift
//  DataProvider
//
//  Created by İbrahim Kültepe on 29.05.2023.
//

public struct RecipeDetail: Decodable {
    public let id: Int
    public let title: String?
    public let ingredients: String?
    public let directions: String?
    public let isLiked: Bool
    public let difference: String?
    public let isEditorChoice: Bool
    public let likeCount: Int
    public let commentCount: Int
    public let user: User
    public let category: RecipeCategory
    public let images: [Image]
    public let numberOfPerson: NumberOfPerson
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case ingredients
        case directions
        case isLiked = "is_liked"
        case difference
        case isEditorChoice = "is_editor_choice"
        case likeCount = "like_count"
        case commentCount = "comment_count"
        case user
        case category
        case images
        case numberOfPerson = "number_of_person"
    }
}
