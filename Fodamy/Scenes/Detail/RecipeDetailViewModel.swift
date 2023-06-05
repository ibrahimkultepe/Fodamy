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
    
    override func tryAgainButtonTapped() {
        self.hideTryAgainButton?()
        getRecipeDetail()
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

// MARK: - Network
extension RecipeDetailViewModel {
    
    func getRecipeDetail() {
        let request = GetRecipeDetailRequest(recipeId: recipeId)
        self.showActivityIndicatorView?()
        dataProvider.request(for: request) { [weak self] result in
            guard let self = self else { return }
            self.hideActivityIndicatorView?()
            switch result {
            case .success(let response):
                self.setItem(recipeDetail: response)
                self.getDataDidSuccess?()
            case .failure(let error ):
                self.showWarningToast?(error.localizedDescription)
                self.showTryAgainButton?()
            }
        }
    }
}
