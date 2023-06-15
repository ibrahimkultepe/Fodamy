//
//  CommentCellModel.swift
//  UIComponents
//
//  Created by İbrahim Kültepe on 6.06.2023.
//

import UIKit

public protocol CommentCellModelDataSource: AnyObject {
    var userNameAndSurname: String? { get }
    var userImageURL: String? { get }
    var userRecipeAndFollowerCountText: String? { get }
    var difference: String? { get }
    var commentText: String? { get }
}

public protocol CommentCellModelEventSource: AnyObject {}

public protocol CommentCellModelProtocol: CommentCellModelDataSource, CommentCellModelEventSource {}

public final class CommentCellModel: CommentCellModelProtocol {
    
    public var userNameAndSurname: String?
    public var userImageURL: String?
    public var userRecipeAndFollowerCountText: String?
    public var difference: String?
    public var commentText: String?

    public init(userNameAndSurname: String?,
                userImageURL: String?,
                userRecipeAndFollowerCountText: String?,
                difference: String?,
                commentText: String?) {
        self.userNameAndSurname = userNameAndSurname
        self.userImageURL = userImageURL
        self.userRecipeAndFollowerCountText = userRecipeAndFollowerCountText
        self.difference = difference
        self.commentText = commentText
    }
}
