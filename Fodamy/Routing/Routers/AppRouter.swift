//
//  AppRouter.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 3.03.2023.
//

import MobilliumUserDefaults
import UIKit


final class AppRouter: Router, AppRouter.Routes {
    
    typealias Routes = WalkthroughRoute & TabBarRoute
    
    static let shared = AppRouter()
    
    func startApp() {
        if DefaultsKey.isWalkthroughFinished.value == true {
            placeOnWindowTabBar()
        } else {
            placeOnWindowWalkthrough()
        }
    }
}
