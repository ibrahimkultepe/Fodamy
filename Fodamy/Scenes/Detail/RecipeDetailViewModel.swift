//
//  RecipeDetailViewModel.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 26.05.2023.
//

import KeychainSwift

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
    var recipeCount: Int?
    var isFollowing = false
    var followUserId: Int?
    var isLiked = false
    
    var getDataDidSuccess: VoidClosure?
    var followingStatus: VoidClosure?
    var likedStatus: VoidClosure?
    var unfollowShowAlert: VoidClosure?

    var recipeImageCellItems = [RecipeDetailCellModelProtocol]()
    var commentCellıtems = [CommentCellModelProtocol]()
    
    var userFollowedCount: Int? {
        didSet {
            recipeAndFollower = "\(recipeCount ?? 0) Tarif \(userFollowedCount ?? 0) Takipçi"
        }
    }
        
    private let dispatchGroup = DispatchGroup()
    private var isGetRecipeDetailSuccess = false
    private var isGetRecipeCommentSuccess = false
    
    private let keychain = KeychainSwift()
    
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
        recipeCount = recipeDetail.user.recipeCount
        userFollowedCount = recipeDetail.user.followedCount
        userNameAndSurname = "\(recipeDetail.user.name ?? "") \(recipeDetail.user.surname ?? "")"
        recipeAndFollower = "\(recipeCount ?? 0) Tarif \(userFollowedCount ?? 0) Takipçi"
        numberOfPerson = recipeDetail.numberOfPerson.text
        ingredients = recipeDetail.ingredients
        directions = recipeDetail.directions
        isFollowing = recipeDetail.user.isFollowing
        followUserId = recipeDetail.user.id
        isLiked = recipeDetail.isLiked
    }
    
    init(recipeId: Int, router: RecipeDetailRouter) {
        self.recipeId = recipeId
        super.init(router: router)
    }
}

// MARK: - Actions
extension RecipeDetailViewModel {
    
    func likeButtonTapped() {
        guard keychain.get(Keychain.token) != nil else {
            router.presentLogin()
            return
        }
        switch isLiked {
        case true:
            self.recipeLikeRequest(likeType: .unlike)
        case false:
            self.recipeLikeRequest(likeType: .like)
        }
    }
    
    func followButtonTapped() {
        guard keychain.get(Keychain.token) != nil else {
            router.presentLogin()
            return
        }
        switch isFollowing {
        case true:
            self.unfollowShowAlert?()
        case false:
            self.userFollowRequest(followType: .follow)
        }
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
    
     func userFollowRequest(followType: UserFollowRequest.FollowStatus) {
        guard let followUserId = followUserId else { return }
         showLoading?()
        let request = UserFollowRequest(followUserId: followUserId, followStatus: followType)
        dataProvider.request(for: request) { [weak self] (result) in
            guard let self = self else { return }
            self.hideLoading?()
            switch result {
            case .success(let response):
                self.followingStatus?()
            case .failure(let error):
                self.showWarningToast?(error.localizedDescription)
            }
        }
    }
    
     private func recipeLikeRequest(likeType: RecipeLikeRequest.LikeType) {
         showLoading?()
        let recipeId = self.recipeId
        let request = RecipeLikeRequest(recipeId: recipeId, likeType: likeType)
        dataProvider.request(for: request) { [weak self] (result) in
            guard let self = self else { return }
            self.hideLoading?()
            switch result {
            case .success(let response):
                self.likedStatus?()
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
