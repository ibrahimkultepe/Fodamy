//
//  RegisterRoute.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 5.06.2023.
//

protocol RegisterRoute {
    func presentRegister()
}

extension RegisterRoute where Self: RouterProtocol {
    
    func presentRegister() {
        let router = RegisterRouter()
        let viewModel = RegisterViewModel(router: router)
        let viewController = RegisterViewController(viewModel: viewModel)
        
        let transition = PlaceOnWindowTransition()
        router.viewController = viewController
        router.openTransition = transition
        
        open(viewController, transition: transition)
    }
}
