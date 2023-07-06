//
//  CommentSectionViewModel.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 28.06.2023.
//

import KeychainSwift

protocol CommentSectionViewDataSource {}

protocol CommentSectionViewEventSource {}

protocol CommentSectionViewProtocol: CommentSectionViewDataSource, CommentSectionViewEventSource {}

final class CommentSectionViewModel: BaseViewModel<CommentSectionRouter>, CommentSectionViewProtocol {
    
    private var recipeId: Int
    
    private var page = 1
    
    var isPagingEnabled = false
    var isRequestEnabled = false

    var getRecipeCommentDidSuccess: VoidClosure?
    var reloadData: VoidClosure?
    var postRecipeCommentDidSuccess: VoidClosure?
    
    private let keychain = KeychainSwift()

    var cellItems = [CommentCellModelProtocol]()
    
    var numberOfItems: Int {
        return cellItems.count
    }
    
    func cellItemForAt(indexPath: IndexPath) -> CommentCellModelProtocol {
        return cellItems[indexPath.row]
    }
    
    func refreshData() {
        page = 1
        self.reloadData?()
        getRecipeComment(showLoading: false)
    }
    
    override func tryAgainButtonTapped() {
        self.hideTryAgainButton?()
        getRecipeComment(showLoading: true)
    }
    
    init(recipeId: Int, router: CommentSectionRouter) {
        self.recipeId = recipeId
        super.init(router: router)
    }
}

// MARK: - Actions
extension CommentSectionViewModel {
    
    func sendButtonTapped(commentText: String) {
        guard keychain.get(Keychain.token) != nil else {
            router.presentLogin()
            return
        }
        postRecipeComment(commentText: commentText)
    }
}

// MARK: - Network
extension CommentSectionViewModel {
    
    func getRecipeComment(showLoading: Bool) {
        self.isRequestEnabled = false
        if showLoading { self.showLoading?() }
        let request = GetRecipeCommentRequest(recipeId: recipeId, page: page)
        dataProvider.request(for: request) { [weak self] result in
            guard let self = self else { return }
            self.hideLoading?()
            self.isRequestEnabled = true
            switch result {
            case .success(let response):
                if self.page == 1 {
                    self.cellItems.removeAll()
                }
                let cellItems = response.data.map({ CommentCellModel(recipeComment: $0) })
                self.cellItems.append(contentsOf: cellItems)
                self.page += 1
                self.isPagingEnabled = response.pagination.lastPage > response.pagination.currentPage
                self.getRecipeCommentDidSuccess?()
            case .failure(let error):
                self.showWarningToast?(error.localizedDescription)
                self.showTryAgainButton?()
            }
        }
    }
    
    private func postRecipeComment(commentText: String) {
        showLoading?()
        let request = PostRecipeCommentRequest(recipeId: recipeId, commentText: commentText)
        dataProvider.request(for: request) { [weak self] (result) in
            guard let self = self else { return }
            self.hideLoading?()
            switch result {
            case .success(let response):
                self.page = 1
                self.getRecipeComment(showLoading: true)
                self.postRecipeCommentDidSuccess?()
            case .failure(let error):
                self.showWarningToast?(error.localizedDescription)
            }
        }
    }
}
