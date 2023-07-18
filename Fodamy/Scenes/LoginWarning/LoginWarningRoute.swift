//
//  LoginWarningRoute.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 12.06.2023.
//

protocol LoginWarningRoute {
    func pushLoginWarning(loginButtonTapped: VoidClosure?)
}

extension LoginWarningRoute where Self: RouterProtocol {
    
    func pushLoginWarning(loginButtonTapped: VoidClosure?) {
        let router = LoginWarningRouter()
        let viewModel = LoginWarningViewModel(router: router, loginButtonTapped: loginButtonTapped)
        let viewController = LoginWarningViewController(viewModel: viewModel)
        
        let transition = ModalTransition()
        transition.modalPresentationStyle = .overFullScreen
        router.viewController = viewController
        router.openTransition = transition
        
        open(viewController, transition: transition)
    }
}
