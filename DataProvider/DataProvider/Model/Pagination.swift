//
//  Pagination.swift
//  DataProvider
//
//  Created by İbrahim Kültepe on 16.05.2023.
//

public struct Pagination: Decodable {
    public let total: Int
    public let perPage: Int
    public let currentPage: Int
    public let lastPage: Int
    public let firstItem: Int?
    public let lastItem: Int?
    
    enum CodingKeys: String, CodingKey {
        case total
        case perPage = "per_page"
        case currentPage = "current_page"
        case lastPage = "last_page"
        case firstItem = "first_item"
        case lastItem = "last_item"
    }
}
