//
//  FavoritesViewController.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 20.04.2023.
//

final class FavoritesViewController: BaseViewController<FavoritesViewModel> {
    
    private let refreshControl = UIRefreshControl()
    
    private let collectionView = UICollectionViewBuilder()
        .backgroundColor(.clear)
        .build()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavigationBarLogo()
        addSubviews()
        configureContent()
        subscribeViewModel()
        viewModel.getFavoritesData(showLoading: true)
    }
}

// MARK: - UILayout
extension FavoritesViewController {
    
    private func addSubviews() {
        view.addSubview(collectionView)
        collectionView.topToSuperview(usingSafeArea: true).constant = 13
        collectionView.edgesToSuperview(excluding: .top)
    }
}

// MARK: - ConfigureContent
extension FavoritesViewController {
    
    private func configureContent() {
        view.backgroundColor = .appSecondaryBackground
        collectionView.register(FavoritesCollectionViewCell.self)
        collectionView.registerFooter(ActivityIndicatorViewFooterView.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
}

// MARK: - Actions
extension FavoritesViewController {
    
    @objc
    private func refreshData() {
        viewModel.refreshData()
    }
}

// MARK: - UIScrollViewDelegate
extension FavoritesViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let viewHeight = scrollView.frame.height
        
        if contentOffsetY > (contentHeight - viewHeight) && viewModel.isPagingEnabled && !viewModel.isRequestEnabled {
            viewModel.getFavoritesData(showLoading: false)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension FavoritesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FavoritesCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        let cellItem = viewModel.cellItemForAt(indexPath: indexPath)
        cellItem.didSelectRecipeDetail = { [weak self] id in
            self?.viewModel.didSelectRecipe(recipeId: id)
        }
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
extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.bounds.width
        let cellHeight = CGFloat(265)
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 28
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 13, left: 0, bottom: 13, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {
        let height: CGFloat = viewModel.isPagingEnabled ? 50 : 0
        return CGSize(width: collectionView.bounds.width, height: height)
    }
}

// MARK: - SubscribeViewModel
extension FavoritesViewController {
    
    private func subscribeViewModel() {
        viewModel.didSuccessGetFavoritesData = { [weak self] in
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
