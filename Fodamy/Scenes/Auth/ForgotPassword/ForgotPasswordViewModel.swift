//
//  ForgotPasswordViewModel.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 16.06.2023.
//

protocol ForgotPasswordViewDataSource {}

protocol ForgotPasswordViewEventSource {}

protocol ForgotPasswordViewProtocol: ForgotPasswordViewDataSource, ForgotPasswordViewEventSource {}

final class ForgotPasswordViewModel: BaseViewModel<ForgotPasswordRouter>, ForgotPasswordViewProtocol {
    
    var didSuccessPasswordReset: VoidClosure?
    
    func dismissVC() {
        router.close()
    }
}

// MARK: - Network
extension ForgotPasswordViewModel {
    
    func forgotPasswordRequest(email: String) {
        showLoading?()
        let request = ForgotPasswordRequest(email: email)
        dataProvider.request(for: request) { [weak self] result in
            guard let self = self else { return }
            self.hideLoading?()
            switch result {
            case .success:
                self.didSuccessPasswordReset?()
            case .failure(let error):
                self.showWarningToast?(error.localizedDescription)
            }
        }
    }
}
