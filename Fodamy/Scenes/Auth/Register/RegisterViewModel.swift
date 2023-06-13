//
//  RegisterViewModel.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 5.06.2023.
//

import DataProvider

protocol RegisterViewDataSource {}

protocol RegisterViewEventSource {}

protocol RegisterViewProtocol: RegisterViewDataSource, RegisterViewEventSource {}

final class RegisterViewModel: BaseViewModel<RegisterRouter>, RegisterViewProtocol {
    
    func presentLoginVC(){
        router.presentLogin()
    }
}

// MARK: - Network
extension RegisterViewModel {
    
    func registerRequest(userName: String, email: String, password: String) {
        let request = RegisterRequest(userName: userName, email: email, password: password)
        self.showActivityIndicatorView?()
        dataProvider.request(for: request) { [weak self] result in
            guard let self = self else { return }
            self.hideActivityIndicatorView?()
            switch result {
            case .success(let response):
                self.presentLoginVC()
            case .failure(let error ):
                self.showWarningToast?(error.localizedDescription)
            }
        }
    }
}
