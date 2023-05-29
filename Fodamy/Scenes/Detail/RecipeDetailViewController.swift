//
//  RecipeDetailViewController.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 26.05.2023.
//

import UIKit

final class RecipeDetailViewController: BaseViewController<RecipeDetailViewModel> {
    
    private let topRecipeView = RecipeDetailImagesView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureContent()
        setLocalize()
    }
}

// MARK: - UILayout
extension RecipeDetailViewController {
    
    private func addSubviews() {
        view.addSubview(topRecipeView)
        topRecipeView.edgesToSuperview()
    }
}

// MARK: - ConfigureContent
extension RecipeDetailViewController {
    
    private func configureContent() {
        
    }
}

// MARK: - SetLocalize
extension RecipeDetailViewController {
    
    private func setLocalize() {
        navigationItem.title = "Your Title"
        navigationController?.navigationBar.topItem?.backButtonTitle = "Geri"
    }
}

// MARK: - Actions
extension RecipeDetailViewController {
    
}
