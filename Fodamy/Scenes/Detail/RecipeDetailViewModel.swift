//
//  RecipeDetailViewModel.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 26.05.2023.
//

import Foundation

protocol RecipeDetailViewDataSource {}

protocol RecipeDetailViewEventSource {}

protocol RecipeDetailViewProtocol: RecipeDetailViewDataSource, RecipeDetailViewEventSource {}

final class RecipeDetailViewModel: BaseViewModel<RecipeDetailRouter>, RecipeDetailViewProtocol {
    
}
