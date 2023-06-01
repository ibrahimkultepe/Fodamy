//
//  RecipeDetailTitlesView.swift
//  UIComponents
//
//  Created by İbrahim Kültepe on 30.05.2023.
//

import UIKit

public class RecipeDetailTitlesView: UIView {
    
    private let recipeNameAndCategoryStackView = UIStackViewBuilder()
        .axis(.vertical)
        .build()
    
    private let recipeNameLabel = UILabelBuilder()
        .font(.font(.nunitoBold, size: .xxLarge))
        .build()
    
    private let recipeCategoryLabel = UILabelBuilder()
        .font(.font(.nunitoSemiBold, size: .large))
        .build()
    
    private let differecenStackView = UIStackViewBuilder()
        .build()
    
    private let differeceLabel = UILabelBuilder()
        .font(.font(.nunitoSemiBold, size: .xxLarge))
        .textAlignment(.right)
        .build()
    
    public var recipeName: String? {
        didSet {
            recipeNameLabel.text = recipeName
        }
    }
    
    public var recipeCategory: String? {
        didSet {
            recipeCategoryLabel.text = recipeCategory
        }
    }
    
    public var differece: String? {
        didSet {
            differeceLabel.text = differece
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UILayout
extension RecipeDetailTitlesView {
    
    private func addSubviews() {
        backgroundColor = .appWhite
        addSubview(recipeNameAndCategoryStackView)
        recipeNameAndCategoryStackView.edgesToSuperview(excluding: .right, insets: .init(top: 12, left: 20, bottom: 12, right: 0))
        
        recipeNameAndCategoryStackView.addArrangedSubview(recipeNameLabel)
        recipeNameAndCategoryStackView.addArrangedSubview(recipeCategoryLabel)
        
        addSubview(differecenStackView)
        differecenStackView.leadingToTrailing(of: recipeNameAndCategoryStackView).constant = 16
        differecenStackView.edgesToSuperview(excluding: .left, insets: .init(top: 13.5, left: 0, bottom: 13.5, right: 20))
        
        differecenStackView.addArrangedSubview(differeceLabel)
    }
}
