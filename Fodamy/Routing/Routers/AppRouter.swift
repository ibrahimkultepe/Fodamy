//
//  AppRouter.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 3.03.2023.
//

import Foundation
import UIKit


final class AppRouter: Router, AppRouter.Routes {
    
    typealias Routes = WalkthroughRoute
    
    static let shared = AppRouter()
    
    func startApp() {
        placeOnWindowWalkthrough()
    }
}
