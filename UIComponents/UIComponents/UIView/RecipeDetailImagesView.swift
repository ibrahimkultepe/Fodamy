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
        .build()
    
    private let pageControl = UIPageControlBuilder()
        .build()
    
    private var cellItems = [RecipeDetailCellModelProtocol]()
    
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
        collectionView.edgesToSuperview(excluding: .bottom)
        
        addSubview(pageControl)
        pageControl.topToBottom(of: collectionView)
        pageControl.centerXToSuperview()
    }
}

// MARK: - ConfigureContent
extension RecipeDetailImagesView {
    
    private func configureContent() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(RecipeDetailCollectionViewCell.self)
    }
}

// MARK: - UICollectionViewDataSource
extension RecipeDetailImagesView: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellItems.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: RecipeDetailCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        let cellItem = cellItems[indexPath.row]
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
