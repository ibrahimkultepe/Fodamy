//
//  FavoritesViewModel.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 20.04.2023.
//

protocol FavoritesViewDataSource {}

protocol FavoritesViewEventSource {}

protocol FavoritesViewProtocol: FavoritesViewDataSource, FavoritesViewEventSource {}

final class FavoritesViewModel: BaseViewModel<FavoritesRouter>, FavoritesViewProtocol {
    
    var page = 1
    
    var isPagingEnabled = false
    var isRequestEnabled = false
    
    var didSuccessGetFavoritesData: VoidClosure?
    var reloadData: VoidClosure?
    
    var cellItems = [FavoritesCellModelProtocol]()
    
    var numberOfItems: Int {
        return cellItems.count
    }
    
    func cellItemForAt(indexPath: IndexPath) -> FavoritesCellModelProtocol {
        return cellItems[indexPath.row]
    }
    
    override func tryAgainButtonTapped() {
        self.hideTryAgainButton?()
        getFavoritesData(showLoading: false)
    }
    
    func refreshData() {
        page = 1
        self.reloadData?()
        getFavoritesData(showLoading: false)
    }
}

// MARK: - Network
extension FavoritesViewModel {
    
    func getFavoritesData(showLoading: Bool) {
        let request = FavoritesRequest(page: page)
        self.isRequestEnabled = true
        if showLoading { self.showActivityIndicatorView?() }
        dataProvider.request(for: request) { [weak self] (result) in
            guard let self = self else { return }
            self.hideActivityIndicatorView?()
            switch result {
            case .success(let response):
                let cellItems = response.data.map({ FavoritesCellModel(category: $0) })
                self.cellItems.append(contentsOf: cellItems)
                self.page += 1
                self.isPagingEnabled = response.pagination.lastPage > response.pagination.currentPage
                self.didSuccessGetFavoritesData?()
            case .failure(let error):
                self.showWarningToast?(error.localizedDescription)
                self.showTryAgainButton?()
            }
            self.isRequestEnabled = false
        }
    }
}
