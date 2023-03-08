//
//  HomeViewModel.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 3.03.2023.
//

import Foundation

protocol HomeViewDataSource {}

protocol HomeViewEventSource {}

protocol HomeViewProtocol: HomeViewDataSource, HomeViewEventSource {}

final class HomeViewModel: BaseViewModel<HomeRouter>, HomeViewProtocol {
    

}
