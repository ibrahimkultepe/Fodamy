//
//  LoginWarningViewModel.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 12.06.2023.
//

import Foundation

protocol LoginWarningViewDataSource {}

protocol LoginWarningViewEventSource {}

protocol LoginWarningViewProtocol: LoginWarningViewDataSource, LoginWarningViewEventSource {}

final class LoginWarningViewModel: BaseViewModel<LoginWarningRouter>, LoginWarningViewProtocol {
    
    func giveUpButtonAction() {
        router.close()
    }
    
    func loginButtonAction() {

    }
}
