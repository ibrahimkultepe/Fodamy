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
    
    var didSuccessGetRecipeData: VoidClosure?
    var errorHandling: VoidClosure?
    
    var cellItems = [RecipeCellModelProtocol]()
    
    var numberOfItems: Int {
        return cellItems.count
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
    
    func getRecipeData(isRefreshing: Bool) {
        var request: RecipeRequest
        switch recipeListType {
        case .recentlyAdded:
            request = RecipeRequest(listType: .recentlyAdded)
        case .editorChoice:
            request = RecipeRequest(listType: .editorChoice)
        }
        if !isRefreshing { self.showActivityIndicatorView?() }
        dataProvider.request(for: request) { [weak self] (result) in
            guard let self = self else { return }
            self.hideActivityIndicatorView?()
            switch result {
            case .success(let response):
                self.cellItems = response.data.map({ RecipeCellModel(recipe: $0) })
                self.didSuccessGetRecipeData?()
            case .failure(let error):
                self.showWarningToast?(error.localizedDescription)
                self.errorHandling?()
            }
        }
    }
}
