//
//  RecipeDetailImageView.swift
//  UIComponents
//
//  Created by İbrahim Kültepe on 29.05.2023.
//

import UIKit
import SKPhotoBrowser

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
    
    public var showSKPhotoBrowserClosure: SKPhotoBrowserClosure?
    
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
        SKPhotoBrowserOptions.displayAction = false
    }
    
    private func showSKPhotoBrowser(photos: [String?], initialPageIndex: Int) -> SKPhotoBrowser {
        let skPhotos = photos.map { SKPhoto.photoWithImageURL($0 ?? "") }
        let browser = SKPhotoBrowser(photos: skPhotos, initialPageIndex: initialPageIndex)
        browser.initializePageIndex(initialPageIndex)
        browser.delegate = self
        return browser
    }
}

// MARK: - UICollectionViewDataSource
extension RecipeDetailImagesView: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photos = recipeDetailData.map { $0.recipeImageURL }
        showSKPhotoBrowserClosure?(showSKPhotoBrowser(photos: photos, initialPageIndex: indexPath.row))
    }
    
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

// MARK: - SKPhotoBrowserDelegate
extension RecipeDetailImagesView: SKPhotoBrowserDelegate {
    
    public func willDismissAtPageIndex(_ index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .top, animated: true)
        pageControl.currentPage = index
    }
}
