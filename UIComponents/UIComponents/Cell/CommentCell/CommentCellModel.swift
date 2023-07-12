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
    var commentId: Int { get }
    var moreButtonTapped: VoidClosure? { get set }
    var isOwner: Bool { get set }
    var userId: Int { get }
}

public protocol CommentCellModelEventSource: AnyObject {}

public protocol CommentCellModelProtocol: CommentCellModelDataSource, CommentCellModelEventSource {}

public final class CommentCellModel: CommentCellModelProtocol {
    
    public var moreButtonTapped: VoidClosure?
    public var userNameAndSurname: String?
    public var userImageURL: String?
    public var userRecipeAndFollowerCountText: String?
    public var difference: String?
    public var commentText: String?
    public var commentId: Int
    public var isOwner: Bool
    public var userId: Int

    public init(userNameAndSurname: String?,
                userImageURL: String?,
                userRecipeAndFollowerCountText: String?,
                difference: String?,
                commentText: String?,
                commentId: Int,
                isOwner: Bool,
                userId: Int) {
        self.userNameAndSurname = userNameAndSurname
        self.userImageURL = userImageURL
        self.userRecipeAndFollowerCountText = userRecipeAndFollowerCountText
        self.difference = difference
        self.commentText = commentText
        self.commentId = commentId
        self.isOwner = isOwner
        self.userId = userId
    }
}
