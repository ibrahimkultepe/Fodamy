//
//  RecipesCollectionViewCell.swift
//  UIComponents
//
//  Created by İbrahim Kültepe on 8.05.2023.
//

import UIKit

public class RecipesCollectionViewCell: UICollectionViewCell, ReusableView {
    
    weak var viewModel: RecipeCellModelProtocol?
    
    private let userView = UserView(followButtonStatus: .hidden)
    
    private let recipesTitleView = UIView()
    private let recipesTitlesStackView = UIStackViewBuilder()
        .axis(.vertical)
        .build()
    
    private let recipeNameLabel = UILabelBuilder()
        .textColor(.appCinder)
        .font(.font(.nunitoSemiBold, size: .xxLarge))
        .build()
    
    private let recipeCategoryLabel = UILabelBuilder()
        .textColor(.appRaven)
        .font(.font(.nunitoSemiBold, size: .large))
        .build()
    
    private let recipeImageView = UIImageViewBuilder()
        .cornerRadius(4)
        .clipsToBounds(true)
        .contentMode(.scaleAspectFill)
        .backgroundColor(.black)
        .build()
    
    private let commentAndLikeView = UIView()
    private let commentAndLikeStackView = UIStackViewBuilder()
        .axis(.horizontal)
        .build()
    
    private let commentAndLikeLabel = UILabelBuilder()
        .textColor(.appRaven)
        .font(.font(.nunitoSemiBold, size: .large))
        .build()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UILayout
extension RecipesCollectionViewCell {
    
    private func addSubviews() {
        contentView.addSubview(userView)
        userView.edgesToSuperview(excluding: .bottom)
        userView.height(65)
        
        contentView.addSubview(recipesTitleView)
        recipesTitleView.topToBottom(of: userView)
        recipesTitleView.edgesToSuperview(excluding: [.top, .bottom], insets: .init(top: 0, left: 20, bottom: 0, right: 20))
        recipesTitleView.height(65)
        
        recipesTitleView.addSubview(recipesTitlesStackView)
        recipesTitlesStackView.edgesToSuperview(insets: .init(top: 12, left: 0, bottom: 12, right: 0))
        recipesTitlesStackView.addArrangedSubview(recipeNameLabel)
        recipesTitlesStackView.addArrangedSubview(recipeCategoryLabel)
        
        contentView.addSubview(recipeImageView)
        recipeImageView.topToBottom(of: recipesTitleView)
        recipeImageView.edgesToSuperview(excluding: [.top, .bottom], insets: .init(top: 0, left: 20, bottom: 0, right: 20))
        recipeImageView.aspectRatio(1)
        
        contentView.addSubview(commentAndLikeView)
        commentAndLikeView.topToBottom(of: recipeImageView)
        commentAndLikeView.edgesToSuperview(excluding: .top, insets: .init(top: 0, left: 20, bottom: 0, right: 20))
        commentAndLikeView.height(45)
        
        commentAndLikeView.addSubview(commentAndLikeStackView)
        commentAndLikeStackView.edgesToSuperview(insets: .init(top: 12, left: 0, bottom: 12, right: 0), relation: .equalOrLess)
        commentAndLikeStackView.addArrangedSubview(commentAndLikeLabel)
    }
}

//MARK: - SetCellItem
public extension RecipesCollectionViewCell {
    
    func setCellItem(viewModel: RecipeCellModelProtocol) {
        self.viewModel = viewModel
        userView.userNameAndSurname = viewModel.userNameAndSurname
        userView.recipeAndFollower = viewModel.userRecipeAndFollowerCountText
        userView.userImageURL = viewModel.userImageURL
        recipeNameLabel.text = viewModel.recipeTitle
        recipeCategoryLabel.text = viewModel.recipeCategory
        recipeImageView.setImage(viewModel.recipeImageURL)
        commentAndLikeLabel.text = viewModel.recipeCommentAndLikeCountText
    }
}
