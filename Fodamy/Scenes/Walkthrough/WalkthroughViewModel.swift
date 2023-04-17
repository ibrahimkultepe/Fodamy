//
//  WalkthroughViewModel.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 8.03.2023.
//

import Foundation
import UIComponents

protocol WalkthroughViewDataSource {}

protocol WalkthroughViewEventSource {}

protocol WalkthroughViewProtocol: WalkthroughViewDataSource, WalkthroughViewEventSource {}

final class WalkthroughViewModel: BaseViewModel<WalkthroughRouter>, WalkthroughViewProtocol {
    
    let items: [WalkthroughCellModelProtocol] = [WalkThroughCellModel(image: .imgWalkthrough1,
                                                                      title: L10n.WalkThrough.firtsTitle,
                                                                      description: L10n.WalkThrough.description),
                                                 WalkThroughCellModel(image: .imgWalkthrough2,
                                                                      title: L10n.WalkThrough.secondTitle,
                                                                      description: L10n.WalkThrough.description),
                                                 WalkThroughCellModel(image: .imgWalkthrough3,
                                                                      title: L10n.WalkThrough.thirdTitle,
                                                                      description: L10n.WalkThrough.description),
                                                 WalkThroughCellModel(image: .imgWalkthrough4,
                                                                      title: L10n.WalkThrough.fourthTitle,
                                                                      description: L10n.WalkThrough.description)]
    
    func cellItemForAt(indexPath: IndexPath) -> WalkthroughCellModelProtocol {
        return items[indexPath.row]
    }
    
    var numberOfItems: Int {
        return items.count
    }
}

extension WalkthroughViewModel {
    
    func didFinishWalkthrough() {
        let isWalkthroughFinished = UserDefaults.standard
        isWalkthroughFinished.set(true, forKey: L10n.UserDefaultsKeys.didFinishWalkthrough)
        router.placeOnWindowTabBar()
    }
}
