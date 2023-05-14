//
//  RecipeRequest.swift
//  DataProvider
//
//  Created by İbrahim Kültepe on 10.05.2023.
//

public struct RecipeRequest: APIDecodableResponseRequest {
    
    public typealias ResponseType = RecipeData<[Recipe]>

    public var path: String = ""
    public let method: RequestMethod = .get
    
    public init(listType: ListType) {
        switch listType {
        case .editorChoice:
            path = "editor-choices"
        case .recentlyAdded:
            path = "recipe"
        }
    }
}

public enum ListType {
    case editorChoice
    case recentlyAdded
}
