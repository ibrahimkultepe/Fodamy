//
//  LoginRoute.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 13.06.2023.
//

protocol LoginRoute {
    func presentLogin()
}

extension LoginRoute where Self: RouterProtocol {
    
    func presentLogin() {
        let router = LoginRouter()
        let viewModel = LoginViewModel(router: router)
        let viewController = LoginViewController(viewModel: viewModel)
        let navController = UINavigationController(rootViewController: viewController)

        let transition = ModalTransition()
        router.viewController = viewController
        router.openTransition = transition
        
        open(navController, transition: transition)
    }
}
