//
//  LoginViewModel.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 13.06.2023.
//

import KeychainSwift

protocol LoginViewDataSource {}

protocol LoginViewEventSource {}

protocol LoginViewProtocol: LoginViewDataSource, LoginViewEventSource {}

final class LoginViewModel: BaseViewModel<LoginRouter>, LoginViewProtocol {
    
    private let keychain = KeychainSwift()

    func pushRegisterVC() {
        router.pushRegister()
    }
    
    func pushForgotPasswordVC() {
        router.pushForgotPassword()
    }
    
    func vectorButtonTapped() {
        router.close()
    }
}

// MARK: - Network
extension LoginViewModel {
    
    func loginRequest(userName: String, password: String) {
        self.showActivityIndicatorView?()
        let request = LoginRequest(userName: userName, password: password)
        dataProvider.request(for: request) { [weak self] result in
            guard let self = self else { return }
            self.hideActivityIndicatorView?()
            switch result {
            case .success(let response):
                self.keychain.set(response.token, forKey: Keychain.token)
                self.router.close()
            case .failure(let error ):
                self.showWarningToast?(error.localizedDescription)
            }
        }
    }
}
