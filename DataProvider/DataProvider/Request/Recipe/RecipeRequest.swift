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
    public var parameters: RequestParameters = [:]
    
    public init(listType: ListType, page: Int) {
        self.parameters["page"] = page
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
