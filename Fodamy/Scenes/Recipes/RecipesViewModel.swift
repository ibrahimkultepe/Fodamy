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
    
    var reloadData: VoidClosure?
    
    var cellItems = [RecipeCellModelProtocol]()
    
    var numberOfItems: Int {
        return cellItems.count
    }
    
    func cellItemForAt(indexPath: IndexPath) -> RecipeCellModelProtocol {
        return cellItems[indexPath.row]
    }
}

// MARK: - Network
extension RecipesViewModel {
    
    func getRecipeData() {
        self.showActivityIndicatorView?()
        let request = RecipeRequest(listType: .recentlyAdded)
        dataProvider.request(for: request) { [weak self] (result) in
            guard let self = self else { return }
            self.hideActivityIndicatorView?()
            switch result {
            case .success(let response):
                self.cellItems = response.data.map({ RecipeCellModel(recipe: $0) })
                self.reloadData?()
            case .failure(let error):
                self.showWarningToast?(error.localizedDescription)
            }
        }
    }
}
