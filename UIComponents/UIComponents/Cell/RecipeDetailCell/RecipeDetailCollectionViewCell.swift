//
//  RecipeDetailCollectionViewCell.swift
//  UIComponents
//
//  Created by İbrahim Kültepe on 29.05.2023.
//

import UIKit

public class RecipeDetailCollectionViewCell: UICollectionViewCell, ReusableView {
    
    weak var viewModel: RecipeDetailCellModelProtocol?
    
    private let recipeDetailImageView = UIImageViewBuilder()
        .backgroundColor(.clear)
        .contentMode(.scaleToFill)
        .clipsToBounds(true)
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
extension RecipeDetailCollectionViewCell {
    
    private func addSubviews() {
        contentView.addSubview(recipeDetailImageView)
        recipeDetailImageView.edgesToSuperview()
    }
}

//MARK: - SetCellItem
public extension RecipeDetailCollectionViewCell {
    
    func setCellItem(viewModel: RecipeDetailCellModelProtocol) {
        self.viewModel = viewModel
        recipeDetailImageView.setImage(viewModel.recipeImageURL)
    }
}
