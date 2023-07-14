//
//  CommentEditViewModel.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 13.07.2023.
//

protocol CommentEditViewDataSource {}

protocol CommentEditViewEventSource {}

protocol CommentEditViewProtocol: CommentEditViewDataSource, CommentEditViewEventSource {}

final class CommentEditViewModel: BaseViewModel<CommentEditRouter>, CommentEditViewProtocol {
    
    private let recipeId: Int
    private let commentId: Int
    let commentText: String?
    var editCommentDidSuccess: StringClosure?
    
    init(recipeId: Int, commentId: Int, commentText: String?, router: CommentEditRouter) {
        self.recipeId = recipeId
        self.commentId = commentId
        self.commentText = commentText
        super.init(router: router)
    }
}

// MARK: - Network
extension CommentEditViewModel {
    
    func editComment(commentText: String) {
        showLoading?()
        let request = EditRecipeCommentRequest(recipeId: recipeId, commentId: commentId, commentText: commentText)
        dataProvider.request(for: request) { [weak self] (result) in
            guard let self = self else { return }
            self.hideLoading?()
            switch result {
            case .success(let response):
                self.editCommentDidSuccess?(commentText)
                self.showSuccessToast?(response.message ?? "")
                self.router.close()
            case .failure(let error):
                self.showWarningToast?(error.localizedDescription)
            }
        }
    }
}
