//
//  FavoritesRequest.swift
//  DataProvider
//
//  Created by İbrahim Kültepe on 23.05.2023.
//

public struct FavoritesRequest: APIDecodableResponseRequest {
    
    public typealias ResponseType = RecipeData<[MainCategory]>
    
    public let path: String = "category-recipes"
    public let method: RequestMethod = .get
    public var parameters: RequestParameters = [:]
    
    
    public init(page: Int) {
        self.parameters["page"] = page
    }
}
