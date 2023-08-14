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
    
    var showAlert: VoidClosure?
    
    func showLoginVC(){
        router.close()
    }
}

// MARK: - Network
extension RegisterViewModel {
    
    func registerRequest(userName: String, email: String, password: String) {
        self.showActivityIndicatorView?()
        let request = RegisterRequest(userName: userName, email: email, password: password)
        dataProvider.request(for: request) { [weak self] result in
            guard let self = self else { return }
            self.hideActivityIndicatorView?()
            switch result {
            case .success:
                self.showAlert?()
            case .failure(let error):
                self.showWarningToast?(error.localizedDescription)
            }
        }
    }
}
