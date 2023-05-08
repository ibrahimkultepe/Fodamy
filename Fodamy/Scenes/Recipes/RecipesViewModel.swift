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
    
}
