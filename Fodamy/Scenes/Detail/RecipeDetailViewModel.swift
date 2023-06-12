//
//  RecipeDetailViewModel.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 26.05.2023.
//

import Foundation

protocol RecipeDetailViewDataSource {}

protocol RecipeDetailViewEventSource {}

protocol RecipeDetailViewProtocol: RecipeDetailViewDataSource, RecipeDetailViewEventSource {}

final class RecipeDetailViewModel: BaseViewModel<RecipeDetailRouter>, RecipeDetailViewProtocol {
    
    var recipeId: Int
    var recipeTitle: String?
    var recipeCategory: String?
    var difference: String?
    var likeCount: Int?
    var commentCount: Int?
    var userImageURL: String?
    var userNameAndSurname: String?
    var recipeAndFollower: String?
    var numberOfPerson: String?
    var ingredients: String?
    var directions: String?
    
    var getDataDidSuccess: VoidClosure?
    
    var recipeImageCellItems = [RecipeDetailCellModelProtocol]()
    var commentCellıtems = [CommentCellModelProtocol]()
    
    private let dispatchGroup = DispatchGroup()
    private var isGetRecipeDetailSuccess = false
    private var isGetRecipeCommentSuccess = false
    
    override func tryAgainButtonTapped() {
        self.hideTryAgainButton?()
        getData()
    }
    
    private func setItem(recipeDetail: RecipeDetail) {
        let imageModels = recipeDetail.images.map { imageURL in
            return RecipeDetailCellModel(recipeImageURL: imageURL.url)
        }
        recipeImageCellItems.append(contentsOf: imageModels)
        recipeTitle = recipeDetail.title
        recipeCategory = recipeDetail.category.name
        difference = recipeDetail.difference
        likeCount = recipeDetail.likeCount
        commentCount = recipeDetail.commentCount
        userImageURL = recipeDetail.user.image?.url
        userNameAndSurname = "\(recipeDetail.user.name ?? "") \(recipeDetail.user.surname ?? "")"
        recipeAndFollower = "\(recipeDetail.user.recipeCount) Tarif \(recipeDetail.user.followedCount) Takipçi"
        numberOfPerson = recipeDetail.numberOfPerson.text
        ingredients = recipeDetail.ingredients
        directions = recipeDetail.directions
    }
    
    init(recipeId: Int, router: RecipeDetailRouter) {
        self.recipeId = recipeId
        super.init(router: router)
    }
}

// MARK: - Actions
extension RecipeDetailViewModel {
    
    func likeButtonTapped() {
        router.pushLoginWarning()
    }
}

// MARK: - Network
extension RecipeDetailViewModel {
    
    func getRecipeDetail() {
        let request = GetRecipeDetailRequest(recipeId: recipeId)
        dispatchGroup.enter()
        dataProvider.request(for: request) { [weak self] result in
            guard let self = self else { return }
            self.dispatchGroup.leave()
            switch result {
            case .success(let response):
                self.setItem(recipeDetail: response)
                self.isGetRecipeDetailSuccess = true
            case .failure(let error ):
                self.showWarningToast?(error.localizedDescription)
            }
        }
    }
    
    func getRecipeComment() {
        let request = GetRecipeCommentRequest(recipeId: recipeId)
        dispatchGroup.enter()
        dataProvider.request(for: request) { [weak self] result in
            guard let self = self else { return }
            self.dispatchGroup.leave()
            switch result {
            case .success(let response):
                let cellItems = response.data.prefix(3).map({ CommentCellModel(recipeComment: $0) })
                self.commentCellıtems.append(contentsOf: cellItems)
                self.isGetRecipeCommentSuccess = true
            case .failure(let error):
                self.showWarningToast?(error.localizedDescription)
            }
        }
    }
    
    func getData() {
        if !isGetRecipeDetailSuccess || !isGetRecipeCommentSuccess {
            showActivityIndicatorView?()
        }
        
        if !isGetRecipeDetailSuccess {
            getRecipeDetail()
        }
        
        if !isGetRecipeCommentSuccess {
            getRecipeComment()
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main) { [weak self] in
            guard let self = self else { return }
            self.hideActivityIndicatorView?()
            if self.isGetRecipeDetailSuccess && self.isGetRecipeCommentSuccess {
                self.getDataDidSuccess?()
            } else {
                self.showTryAgainButton?()
            }
        }
    }
}
