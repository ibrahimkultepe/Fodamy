//
//  RecipeDetailViewController.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 26.05.2023.
//

import UIKit

final class RecipeDetailViewController: BaseViewController<RecipeDetailViewModel> {
    
    private let scrollView = UIScrollViewBuilder()
        .build()
    
    private let contentStackView = UIStackViewBuilder()
        .axis(.vertical)
        .build()
    
    private let recipeImagesView = RecipeDetailImagesView()
    
    private let recipeDetailTitlesView = RecipeDetailTitlesView()
    
    private let seperator = UIViewBuilder()
        .backgroundColor(.appZircon)
        .build()
    
    private let commentAndLikeStackView = UIStackViewBuilder()
        .axis(.horizontal)
        .distribution(.fillProportionally)
        .spacing(1)
        .build()
    
    private let commentCountView = RecipeDetailCommentAndLikeView()
    private let likeCountView = RecipeDetailCommentAndLikeView()
    
    private let userView = UserView(followButtonStatus: .visible)
    
    private let ingredientsView = RecipeDetailInfoView()
    private let instructionsView = RecipeDetailInfoView()
    
    private let commentView = RecipeDetailCommentView()
    
    private let buttonContainerView = UIView()
    
    private let commentButton = UIButtonBuilder()
        .titleFont(.font(.nunitoBold, size: .xxLarge))
        .titleColor(.appWhite)
        .backgroundColor(.appRed)
        .build()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureContent()
        setLocalize()
        viewModel.getData()
        subscribeViewModel()
    }
}

// MARK: - UILayout
extension RecipeDetailViewController {
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.edgesToSuperview()
        
        scrollView.addSubview(contentStackView)
        contentStackView.edgesToSuperview()
        contentStackView.widthToSuperview()
        
        contentStackView.addArrangedSubview(recipeImagesView)
        recipeImagesView.aspectRatio(1)
        contentStackView.addArrangedSubview(recipeDetailTitlesView)
        contentStackView.setCustomSpacing(1, after: recipeDetailTitlesView)
        contentStackView.addArrangedSubview(seperator)
        
        contentStackView.addArrangedSubview(commentAndLikeStackView)
        commentAndLikeStackView.addArrangedSubview(commentCountView)
        commentAndLikeStackView.addArrangedSubview(seperator)
        commentAndLikeStackView.addArrangedSubview(likeCountView)
        
        contentStackView.setCustomSpacing(19, after: commentAndLikeStackView)
        contentStackView.addArrangedSubview(userView)
        userView.height(65)
        contentStackView.setCustomSpacing(20, after: userView)
        
        contentStackView.addArrangedSubview(ingredientsView)
        contentStackView.setCustomSpacing(20, after: ingredientsView)
        contentStackView.addArrangedSubview(instructionsView)
        contentStackView.setCustomSpacing(20, after: instructionsView)
        
        contentStackView.addArrangedSubview(commentView)
        contentStackView.setCustomSpacing(20, after: commentView)
        
        contentStackView.addArrangedSubview(buttonContainerView)
        buttonContainerView.topToBottom(of: commentView).constant = 20
        buttonContainerView.edgesToSuperview(excluding: .top)
        
        buttonContainerView.addSubview(commentButton)
        commentButton.edgesToSuperview(insets: .init(top: 0, left: 20, bottom: 0, right: 20))
        commentButton.height(50)
    }
}

// MARK: - ConfigureContent
extension RecipeDetailViewController {
    
    private func configureContent() {
        view.backgroundColor = .appSecondaryBackground
        subscribeLikeButton()
        subscribeFollowButton()
        commentButton.addTarget(self, action: #selector(commentButtonAction), for: .touchUpInside)
        NotificationCenter.default.addObserver(forName: .updateRecipeDetailView, object: nil, queue: nil) { [weak self] _ in
            self?.updateRecipeDetail()
        }
    }
    
    private func setItem() {
        navigationItem.title = viewModel.recipeTitle
        recipeImagesView.recipeDetailData = viewModel.recipeImageCellItems
        recipeDetailTitlesView.recipeName = viewModel.recipeTitle
        recipeDetailTitlesView.recipeCategory = viewModel.recipeCategory
        recipeDetailTitlesView.differece = viewModel.difference
        commentCountView.number = viewModel.commentCount
        likeCountView.number = viewModel.likeCount
        userView.userImageURL = viewModel.userImageURL
        userView.userNameAndSurname = viewModel.userNameAndSurname
        userView.recipeAndFollower = viewModel.recipeAndFollower
        ingredientsView.iconText = viewModel.numberOfPerson
        ingredientsView.infoText = viewModel.ingredients
        instructionsView.iconText = viewModel.difference
        instructionsView.infoText = viewModel.directions
        userView.isFollowing = viewModel.isFollowing
    }
    
    private func unfollowShowAlert() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let unfollowAction = UIAlertAction(title: L10n.RecipeDetail.unfollowAction, style: .destructive) { [weak self] _ in
            self?.viewModel.userFollowRequest(followType: .unfollow)
        }
        let cancelAction = UIAlertAction(title: L10n.RecipeDetail.cancelAction, style: .cancel)
        
        alertController.addAction(unfollowAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func updateRecipeDetail() {
        viewModel.resetData()
        viewModel.getData()
    }
}

// MARK: - SetLocalize
extension RecipeDetailViewController {
    
    private func setLocalize() {
        navigationController?.navigationBar.topItem?.backButtonTitle = L10n.NavigationController.backButtonTitle
        commentCountView.iconOfButton = .icComment
        commentCountView.info = L10n.RecipeDetail.commentViewInfo
        likeCountView.iconOfButton = .icHeart
        likeCountView.info = L10n.RecipeDetail.likeViewInfo
        ingredientsView.title = L10n.RecipeDetailInfo.materials
        ingredientsView.iconOfButton = .icRestaurant
        instructionsView.title = L10n.RecipeDetailInfo.instructions
        instructionsView.iconOfButton = .icClock
        commentButton.setTitle(L10n.RecipeDetailComment.buttonTitle, for: .normal)
    }
}

// MARK: - Actions
extension RecipeDetailViewController {
    
    private func subscribeLikeButton() {
        likeCountView.buttonTapped = { [weak self] in
            guard let self = self else { return }
            self.viewModel.likeButtonTapped()
        }
    }
    
    private func subscribeFollowButton() {
        userView.followButtonTapped = { [weak self] in
            guard let self = self else { return }
            self.viewModel.followButtonTapped()
        }
    }
    
    @objc
    private func commentButtonAction() {
        viewModel.commentButtonTapped()
    }
}

// MARK: - SubscribeViewModel
extension RecipeDetailViewController {
    
    private func subscribeViewModel() {
        viewModel.getDataDidSuccess = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.setItem()
                self.commentView.recipeCommentData = self.viewModel.commentCellıtems
            }
        }
        
        viewModel.followingStatus = { [weak self] in
            guard let self = self else { return }
            let isFollowing = self.viewModel.isFollowing
            if isFollowing {
                self.viewModel.userFollowedCount? -= 1
                self.viewModel.isFollowing = false
                self.userView.isFollowing = false
            } else {
                self.viewModel.userFollowedCount? += 1
                self.viewModel.isFollowing = true
                self.userView.isFollowing = true
            }
            self.userView.recipeAndFollower = self.viewModel.recipeAndFollower
        }
        
        viewModel.likedStatus = { [weak self] in
            guard let self = self else { return }
            let isLiked = self.viewModel.isLiked
            if isLiked {
                self.likeCountView.iconColor = .appCinder
                self.viewModel.likeCount? -= 1
                self.likeCountView.number = self.viewModel.likeCount
                self.viewModel.isLiked = false
            } else {
                self.likeCountView.iconColor = .appRed
                self.viewModel.likeCount? += 1
                self.likeCountView.number = self.viewModel.likeCount
                self.viewModel.isLiked = true
            }
        }
        
        viewModel.unfollowShowAlert = { [weak self] in
            guard let self = self else { return }
            self.unfollowShowAlert()
            
        }
    }
}
