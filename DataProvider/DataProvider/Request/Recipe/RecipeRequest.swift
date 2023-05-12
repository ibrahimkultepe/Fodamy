//
//  RecipeRequest.swift
//  DataProvider
//
//  Created by İbrahim Kültepe on 10.05.2023.
//

public struct RecipeRequest: APIDecodableResponseRequest {
    
    public typealias ResponseType = RecipeData<[Items]>

    public var path: String = "recipe"
    public var method: RequestMethod = .get
    
    public init() {}
}
