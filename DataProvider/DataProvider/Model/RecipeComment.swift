//
//  RecipeComment.swift
//  DataProvider
//
//  Created by İbrahim Kültepe on 6.06.2023.
//

public struct RecipeComment: Decodable {
    public let id: Int
    public let text: String?
    public let difference: String?
    public let user: User
}
