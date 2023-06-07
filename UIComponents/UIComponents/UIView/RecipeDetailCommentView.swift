//
//  RecipeDetailCommentView.swift
//  UIComponents
//
//  Created by İbrahim Kültepe on 6.06.2023.
//

import UIKit

public class RecipeDetailCommentView: UIView {
    
    private let topContainerView = UIView()
    
    private let titleLabel = UILabelBuilder()
        .textColor(.black)
        .font(.font(.nunitoBold, size: .xLarge))
        .build()
    
    private let seperator = UIViewBuilder()
        .backgroundColor(.appZircon)
        .build()
    
    private let collectionView = UICollectionViewBuilder<DynamicHeightCollectionView>()
        .backgroundColor(.appWhite)
        .scrollDirection(.vertical)
        .estimatedItemSize(UICollectionViewFlowLayout.automaticSize)
        .build()
    
    public var recipeCommentData: [CommentCellModelProtocol] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
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
extension RecipeDetailCommentView {
    
    private func addSubviews() {
        backgroundColor = .appWhite
        addSubview(topContainerView)
        topContainerView.edgesToSuperview(excluding: .bottom, insets: .init(top: 12, left: 20, bottom: 0, right: 20))
        topContainerView.height(46)
        topContainerView.addSubview(titleLabel)
        titleLabel.edgesToSuperview()

        addSubview(seperator)
        seperator.topToBottom(of: topContainerView).constant = 12
        seperator.edgesToSuperview(excluding: [.top, .bottom])
        seperator.height(1)

        addSubview(collectionView)
        collectionView.topToBottom(of: seperator)
        collectionView.edgesToSuperview(excluding: .top)
    }
}

// MARK: - ConfigureContent
extension RecipeDetailCommentView {
    
    private func configureContent() {
        collectionView.register(CommentCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

// MARK: - SetLocalize
extension RecipeDetailCommentView {
    
    private func setLocalize() {
        titleLabel.text = L10n.RecipeDetailComment.title
    }
}

// MARK: - UICollectionViewDataSource
extension RecipeDetailCommentView: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipeCommentData.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CommentCell = collectionView.dequeueReusableCell(for: indexPath)
        let cellItem = recipeCommentData[indexPath.row]
        cell.setCellItem(viewModel: cellItem)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension RecipeDetailCommentView: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        let XLMargin: CGFloat = 40
        let cellWidth = collectionView.bounds.width - XLMargin
                   return CGSize(width: cellWidth, height: 10)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
