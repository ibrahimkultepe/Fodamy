//
//  MainCategory.swift
//  DataProvider
//
//  Created by İbrahim Kültepe on 23.05.2023.
//

public struct MainCategory: Decodable {
    public let recipes: [Recipe]?
    public let name: String?
    public let id: Int
}
