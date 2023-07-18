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
    
    var loginButtonTapped: VoidClosure?

    func giveUpButtonAction() {
        router.close()
    }
    
    func loginButtonAction() {
        router.dismiss(isAnimated: false) { [weak self] in
            self?.loginButtonTapped?()
        }
    }
    
    init(router: LoginWarningRouter, dataProvider: DataProviderProtocol = apiDataProvider, loginButtonTapped: VoidClosure?) {
        self.loginButtonTapped = loginButtonTapped
        super.init(router: router, dataProvider: dataProvider)
    }
}
