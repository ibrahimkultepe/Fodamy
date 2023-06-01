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
    
    var recipeTitle: String?
    var recipeCategory: String?
    var difference: String?
    var likeCount: Int?
    var commentCount: Int?
    var userImageURL: String?
    var userNameAndSurname: String?
    var recipeAndFollower: String?
    
    var fillData: VoidClosure?
    var recipeImageCellItems = [RecipeDetailCellModelProtocol]()
    
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
    }
}

// MARK: - Network
extension RecipeDetailViewModel {
    
    func getRecipeDetail() {
        let request = GetRecipeDetailRequest(recipeId: 27)
        self.showActivityIndicatorView?()
        dataProvider.request(for: request) { [weak self] result in
            guard let self = self else { return }
            self.hideActivityIndicatorView?()
            switch result {
            case .success(let response):
                self.setItem(recipeDetail: response)
                self.fillData?()
            case .failure(let error ):
                self.showWarningToast?(error.localizedDescription)
                self.showTryAgainButton?()
            }
        }
    }
}
