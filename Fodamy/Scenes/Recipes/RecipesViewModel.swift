//
//  RecipesViewModel.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 2.05.2023.
//

protocol RecipesViewDataSource {}

protocol RecipesViewEventSource {}

protocol RecipesViewProtocol: RecipesViewDataSource, RecipesViewEventSource {}

final class RecipesViewModel: BaseViewModel<RecipesRouter>, RecipesViewProtocol {
    
    private var recipeListType: RecipeListType
    
    var page = 1
    
    var isPagingEnabled = false
    var isRequestEnabled = false
    
    var didSuccessGetRecipeData: VoidClosure?
    
    var cellItems = [RecipeCellModelProtocol]()
    
    var numberOfItems: Int {
        return cellItems.count
    }
    
    override func tryAgainButtonTapped() {
        self.hideTryAgainButton?()
        getRecipeData(showLoading: false)
    }
    
    func cellItemForAt(indexPath: IndexPath) -> RecipeCellModelProtocol {
        return cellItems[indexPath.row]
    }
    
    enum RecipeListType {
        case recentlyAdded
        case editorChoice
    }
    
    init(recipeListType: RecipeListType, router: RecipesRouter) {
        self.recipeListType = recipeListType
        super.init(router: router)
    }
}

// MARK: - Network
extension RecipesViewModel {
    
    func getRecipeData(showLoading: Bool) {
        var request: RecipeRequest
        switch recipeListType {
        case .recentlyAdded:
            request = RecipeRequest(listType: .recentlyAdded, page: page)
        case .editorChoice:
            request = RecipeRequest(listType: .editorChoice, page: page)
        }
        self.isRequestEnabled = false
        if showLoading { self.showActivityIndicatorView?() }
        dataProvider.request(for: request) { [weak self] (result) in
            guard let self = self else { return }
            self.hideActivityIndicatorView?()
            switch result {
            case .success(let response):
                let cellItems = response.data.map({ RecipeCellModel(recipe: $0) })
                self.cellItems.append(contentsOf: cellItems)
                self.page += 1
                self.isPagingEnabled = response.pagination.lastPage > response.pagination.currentPage
                self.didSuccessGetRecipeData?()
            case .failure(let error):
                self.showWarningToast?(error.localizedDescription)
                self.showTryAgainButton?()
            }
        }
        self.isRequestEnabled = true
    }
}
