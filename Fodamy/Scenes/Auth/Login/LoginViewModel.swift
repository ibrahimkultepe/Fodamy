//
//  LoginViewModel.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 13.06.2023.
//

import Foundation

protocol LoginViewDataSource {}

protocol LoginViewEventSource {}

protocol LoginViewProtocol: LoginViewDataSource, LoginViewEventSource {}

final class LoginViewModel: BaseViewModel<LoginRouter>, LoginViewProtocol {
    
    func pushRegisterVC() {
        router.pushRegister()
    }
}
