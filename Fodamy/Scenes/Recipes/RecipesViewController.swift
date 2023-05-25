//
//  RecipesViewController.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 2.05.2023.
//

import UIKit

final class RecipesViewController: BaseViewController<RecipesViewModel> {
    
    private let refreshControl = UIRefreshControl()
    
    private let collectionView = UICollectionViewBuilder()
        .backgroundColor(.appWhite)
        .build()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureContent()
        subscribeViewModel()
        viewModel.getRecipeData(showLoading: true)
    }
}

// MARK: - UILayout
extension RecipesViewController {
    
    private func addSubviews() {
        view.addSubview(collectionView)
        collectionView.topToSuperview().constant = 16
        collectionView.edgesToSuperview(excluding: .top)
    }
}

// MARK: - ConfigureContent
extension RecipesViewController {
    
    private func configureContent() {
        view.backgroundColor = .appSecondaryBackground
        collectionView.register(RecipesCollectionViewCell.self)
        collectionView.registerFooter(ActivityIndicatorViewFooterView.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
}

// MARK: - Actions
extension RecipesViewController {
    
    @objc
    private func refreshData() {
        viewModel.refreshData()
    }
}

// MARK: - UIScrollViewDelegate
extension RecipesViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let viewHeight = scrollView.frame.height
        
        if contentOffsetY > (contentHeight - viewHeight) && viewModel.isPagingEnabled && !viewModel.isRequestEnabled {
            viewModel.getRecipeData(showLoading: false)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension RecipesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: RecipesCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        let cellItem = viewModel.cellItemForAt(indexPath: indexPath)
        cell.setCellItem(viewModel: cellItem)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let footer: ActivityIndicatorViewFooterView = collectionView.dequeueReusableCell(ofKind: kind, for: indexPath)
            return footer
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplaySupplementaryView view: UICollectionReusableView,
                        forElementKind elementKind: String,
                        at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter,
           let view = view as? ActivityIndicatorViewFooterView,
           viewModel.isPagingEnabled {
            view.startLoading()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didEndDisplayingSupplementaryView view: UICollectionReusableView,
                        forElementOfKind elementKind: String,
                        at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter,
           let view = view as? ActivityIndicatorViewFooterView,
           viewModel.isPagingEnabled {
            view.stopLoading()
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension RecipesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.bounds.width
        let imageHeight = cellWidth - 40
        let cellHeight = imageHeight + CGFloat(175)
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 16, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {
        let height: CGFloat = viewModel.isPagingEnabled ? 50 : 0
        return CGSize(width: collectionView.bounds.width, height: height)
    }
}

// MARK: - SubscribeViewModel
extension RecipesViewController {
    
    func subscribeViewModel() {
        viewModel.didSuccessGetRecipeData = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
        viewModel.reloadData = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}
