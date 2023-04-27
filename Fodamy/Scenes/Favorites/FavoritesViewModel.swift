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
    
}
