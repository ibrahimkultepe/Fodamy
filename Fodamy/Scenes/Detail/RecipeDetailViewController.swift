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
    
    private let commentView = RecipeDetailCommentAndLikeView()
    private let likeView = RecipeDetailCommentAndLikeView()
    
    private let userView = UserView()
    
    private let ingredientsView = RecipeDetailInfoView()
    private let instructionsView = RecipeDetailInfoView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureContent()
        setLocalize()
        viewModel.getRecipeDetail()
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
        commentAndLikeStackView.addArrangedSubview(commentView)
        commentAndLikeStackView.addArrangedSubview(seperator)
        commentAndLikeStackView.addArrangedSubview(likeView)
        
        contentStackView.setCustomSpacing(19, after: commentAndLikeStackView)
        contentStackView.addArrangedSubview(userView)
        userView.height(65)
        contentStackView.setCustomSpacing(20, after: userView)
        
        contentStackView.addArrangedSubview(ingredientsView)
        contentStackView.setCustomSpacing(20, after: ingredientsView)
        contentStackView.addArrangedSubview(instructionsView)
    }
}

// MARK: - ConfigureContent
extension RecipeDetailViewController {
    
    private func configureContent() {
        view.backgroundColor = .appSecondaryBackground
    }
    
    private func setItem() {
        navigationItem.title = viewModel.recipeTitle
        recipeImagesView.recipeDetailData = viewModel.recipeImageCellItems
        recipeDetailTitlesView.recipeName = viewModel.recipeTitle
        recipeDetailTitlesView.recipeCategory = viewModel.recipeCategory
        recipeDetailTitlesView.differece = viewModel.difference
        commentView.number = viewModel.commentCount
        likeView.number = viewModel.likeCount
        userView.userImageURL = viewModel.userImageURL
        userView.userNameAndSurname = viewModel.userNameAndSurname
        userView.recipeAndFollower = viewModel.recipeAndFollower
        ingredientsView.iconText = viewModel.numberOfPerson
        ingredientsView.infoText = viewModel.ingredients
        instructionsView.iconText = viewModel.difference
        instructionsView.infoText = viewModel.directions
    }
}

// MARK: - SetLocalize
extension RecipeDetailViewController {
    
    private func setLocalize() {
        navigationController?.navigationBar.topItem?.backButtonTitle = L10n.NavigationController.backButtonTitle
        commentView.iconOfButton = .icComment
        commentView.info = L10n.RecipeDetail.commentViewInfo
        likeView.iconOfButton = .icHeart
        likeView.info = L10n.RecipeDetail.likeViewInfo
        ingredientsView.title = L10n.RecipeDetailInfo.materials
        ingredientsView.iconOfButton = .icRestaurant
        instructionsView.title = L10n.RecipeDetailInfo.instructions
        instructionsView.iconOfButton = .icClock
    }
}

// MARK: - SubscribeViewModel
extension RecipeDetailViewController {
    
    private func subscribeViewModel() {
        viewModel.getDataDidSuccess = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.setItem()
            }
        }
    }
}
