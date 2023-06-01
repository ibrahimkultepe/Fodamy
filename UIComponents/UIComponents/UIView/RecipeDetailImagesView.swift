//
//  RecipeDetailImageView.swift
//  UIComponents
//
//  Created by İbrahim Kültepe on 29.05.2023.
//

import UIKit

public class RecipeDetailImagesView: UIView {
    
    private let collectionView = UICollectionViewBuilder()
        .backgroundColor(.clear)
        .scrollDirection(.horizontal)
        .build()
    
    private let pageControl = UIPageControlBuilder()
        .isUserInteractionEnabled(false)
        .hidesForSinglePage(true)
        .build()
    
    public var recipeDetailData: [RecipeDetailCellModelProtocol] = [] {
        didSet {
            collectionView.reloadData()
            pageControl.numberOfPages = recipeDetailData.count
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        configureContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UILayout
extension RecipeDetailImagesView {
    
    private func addSubviews() {
        addSubview(collectionView)
        collectionView.edgesToSuperview()
        
        addSubview(pageControl)
        pageControl.bottom(to: collectionView)
        pageControl.centerX(to: collectionView)
    }
}

// MARK: - ConfigureContent
extension RecipeDetailImagesView {
    
    private func configureContent() {
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(RecipeDetailCollectionViewCell.self)
    }
}

// MARK: - UICollectionViewDataSource
extension RecipeDetailImagesView: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipeDetailData.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: RecipeDetailCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        let cellItem = recipeDetailData[indexPath.row]
        cell.setCellItem(viewModel: cellItem)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension RecipeDetailImagesView: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
}
