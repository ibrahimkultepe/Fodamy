//
//  WalkthroughViewModel.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 8.03.2023.
//

import Foundation

protocol WalkthroughViewDataSource {}

protocol WalkthroughViewEventSource {}

protocol WalkthroughViewProtocol: WalkthroughViewDataSource, WalkthroughViewEventSource {}

final class WalkthroughViewModel: BaseViewModel<WalkthroughRouter>, WalkthroughViewProtocol {
        
    let items = [WalkthroughCellModel(image: .imgWalkthrough, title: firtsTitle, description: description),
                 WalkthroughCellModel(image: .imgWalkthrough2, title: secondTitle, description: description),
                 WalkthroughCellModel(image: .imgWalkthrough3, title: thirdTitle, description: description),
                 WalkthroughCellModel(image: .imgWalkthrough4, title: fourthTitle, description: description)]
    
    func cellItemForAt(indexPath: IndexPath) -> WalkthroughCellModel {
        return items[indexPath.row]
    }
    
    var numberOfItems: Int {
        return items.count
    }
}
