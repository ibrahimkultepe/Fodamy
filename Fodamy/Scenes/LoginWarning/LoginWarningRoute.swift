//
//  LoginWarningRoute.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 12.06.2023.
//

protocol LoginWarningRoute {
    func pushLoginWarning()
}

extension LoginWarningRoute where Self: RouterProtocol {
    
    func pushLoginWarning() {
        let router = LoginWarningRouter()
        let viewModel = LoginWarningViewModel(router: router)
        let viewController = LoginWarningViewController(viewModel: viewModel)
        
        let transition = ModalTransition()
        transition.modalPresentationStyle = .overFullScreen
        router.viewController = viewController
        router.openTransition = transition
        
        open(viewController, transition: transition)
    }
}
