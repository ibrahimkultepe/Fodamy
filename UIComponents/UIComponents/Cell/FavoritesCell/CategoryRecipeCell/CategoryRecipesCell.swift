//
//  CategoryRecipesCell.swift
//  UIComponents
//
//  Created by İbrahim Kültepe on 22.05.2023.
//

import UIKit

public class CategoryRecipesCell: UICollectionViewCell, ReusableView {
    
    weak var viewModel: CategoryRecipesCellProtocol?
    
    private let recipeImageView = UIImageViewBuilder()
        .contentMode(.scaleToFill)
        .clipsToBounds(true)
        .cornerRadius(4)
        .build()
    
    private let recipeNameAndCommentAndLikeLabelStackView = UIStackViewBuilder()
        .axis(.vertical)
        .build()
    
    private let recipeTitleLabel = UILabelBuilder()
        .textColor(.appCinder)
        .font(.font(.nunitoSemiBold, size: .xxLarge))
        .adjustsFontSizeToFitWidth(true)
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
extension CategoryRecipesCell {
    
    private func addSubviews() {
        contentView.addSubview(recipeImageView)
        recipeImageView.edgesToSuperview(excluding: .bottom)
        recipeImageView.size(CGSize(width: 154, height: 120))
        
        contentView.addSubview(recipeNameAndCommentAndLikeLabelStackView)
        recipeNameAndCommentAndLikeLabelStackView.topToBottom(of: recipeImageView).constant = 12
        recipeNameAndCommentAndLikeLabelStackView.edgesToSuperview(excluding: .top,
                                                                   insets: .init(top: 0, left: 8, bottom: 12, right: 8))
        recipeNameAndCommentAndLikeLabelStackView.addArrangedSubview(recipeTitleLabel)
        recipeNameAndCommentAndLikeLabelStackView.addArrangedSubview(commentAndLikeLabel)
    }
}

//MARK: - SetCellItem
public extension CategoryRecipesCell {
    
    func setCellItem(viewModel: CategoryRecipesCellProtocol) {
        self.viewModel = viewModel
        recipeImageView.setImage(viewModel.recipeImageURL)
        recipeTitleLabel.text = viewModel.recipeTitle
        commentAndLikeLabel.text = viewModel.recipeCommentAndLikeCountText
    }
}
