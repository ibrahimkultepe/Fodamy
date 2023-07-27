//
//  FavoritesCollectionViewCell.swift
//  UIComponents
//
//  Created by İbrahim Kültepe on 22.05.2023.
//

import UIKit

public class FavoritesCollectionViewCell: UICollectionViewCell, ReusableView {
    
    weak var viewModel: FavoritesCellModelProtocol?
    
    private let topContainerView = UIViewBuilder()
        .build()
    
    private let categoryImageAndCategoryLabelStackView = UIStackViewBuilder()
        .axis(.horizontal)
        .spacing(12)
        .build()
    
    private let buttonStackView = UIStackViewBuilder()
        .build()
    
    private let categoryImageView = UIImageViewBuilder()
        .contentMode(.scaleToFill)
        .clipsToBounds(true)
        .build()
    
    private let categoryLabel = UILabelBuilder()
        .textColor(.black)
        .font(.font(.nunitoBold, size: .xxLarge))
        .build()
    
    private let seeAllButton = UIButtonBuilder()
        .titleFont(.font(.nunitoBold, size: .xxLarge))
        .titleColor(.appRed)
        .build()
    
    private let seperator = UIViewBuilder()
        .backgroundColor(.appZircon)
        .build()
    
    private let recipeCollectionView = UICollectionViewBuilder()
        .scrollDirection(.horizontal)
        .showsHorizontalScrollIndicator(false)
        .build()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        configureContent()
        setLocalize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UILayout
extension FavoritesCollectionViewCell {
    
    private func addSubviews() {
        contentView.addSubview(topContainerView)
        topContainerView.topToSuperview().constant = 12
        topContainerView.edgesToSuperview(excluding: [.bottom, .top])
        topContainerView.addSubview(categoryImageAndCategoryLabelStackView)
        topContainerView.addSubview(buttonStackView)
        
        categoryImageAndCategoryLabelStackView.edgesToSuperview(excluding: .right, insets: .init(top: 4, left: 16, bottom: 4, right: 0))
        categoryImageAndCategoryLabelStackView.addArrangedSubview(categoryImageView)
        categoryImageView.size(.init(width: 24, height: 24))
        categoryImageAndCategoryLabelStackView.addArrangedSubview(categoryLabel)
        
        buttonStackView.leadingToTrailing(of: categoryImageAndCategoryLabelStackView)
        buttonStackView.edgesToSuperview(excluding: .left, insets: .init(top: 4, left: 0, bottom: 4, right: 16))
        buttonStackView.addArrangedSubview(seeAllButton)
        
        contentView.addSubview(seperator)
        seperator.topToBottom(of: topContainerView)
        seperator.size(CGSize(width: contentView.frame.width, height: 1))
        
        contentView.addSubview(recipeCollectionView)
        recipeCollectionView.topToBottom(of: seperator)
        recipeCollectionView.edgesToSuperview(excluding: .top)
    }
}

// MARK: - ConfigureContent
extension FavoritesCollectionViewCell {
    
    private func configureContent() {
        contentView.backgroundColor = .appWhite
        recipeCollectionView.register(CategoryRecipesCell.self)
        recipeCollectionView.dataSource = self
        recipeCollectionView.delegate = self
        seeAllButton.addTarget(self, action: #selector(seeAllButtonAction), for: .touchUpInside)
    }
}

// MARK: - SetLocalize
extension FavoritesCollectionViewCell {
    
    private func setLocalize() {
        seeAllButton.setTitle(L10n.FavoritesCollectionViewCell.seeAllButton, for: .normal)
    }
}

// MARK: - Actions
extension FavoritesCollectionViewCell {
    
    @objc
    private func seeAllButtonAction() {
        guard let categoryId = viewModel?.categoryId else { return }
        viewModel?.seeAllButtonTapped?(categoryId)
    }
}

// MARK: - UICollectionViewDataSource
extension FavoritesCollectionViewCell: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cellItem = viewModel?.cellItems?[indexPath.row] else { return }
        viewModel?.didSelectRecipeDetail?(cellItem.recipeId)
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfItems ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CategoryRecipesCell = collectionView.dequeueReusableCell(for: indexPath)
        if let cellItem = viewModel?.cellItemForAt(indexPath: indexPath) {
            cell.setCellItem(viewModel: cellItem)
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FavoritesCollectionViewCell: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = CGFloat(154)
        let cellHeight = CGFloat(185)
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 16, bottom: 16, right: 16)
    }
}

//MARK: - SetCellItem
public extension FavoritesCollectionViewCell {
    
    func setCellItem(viewModel: FavoritesCellModelProtocol) {
        self.viewModel = viewModel
        recipeCollectionView.reloadData()
        categoryImageView.setImage(viewModel.categoryImageURL)
        categoryLabel.text = viewModel.recipeCategory
    }
}
