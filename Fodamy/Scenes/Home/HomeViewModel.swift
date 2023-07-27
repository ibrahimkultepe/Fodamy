//
//  HomeViewModel.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 20.04.2023.
//

protocol HomeViewDataSource {}

protocol HomeViewEventSource {}

protocol HomeViewProtocol: HomeViewDataSource, HomeViewEventSource {}

final class HomeViewModel: BaseViewModel<HomeRouter>, HomeViewProtocol {
    
    var selectedSegmentIndex = 0
    var didSuccesLogout: VoidClosure?
}

// MARK: - Network
extension HomeViewModel {
    
    func userLogoutRequest() {
        showLoading?()
        let request = LogoutRequest()
        dataProvider.request(for: request) { [weak self] (result) in
            guard let self = self else { return }
            self.hideLoading?()
            switch result {
            case .success(let response):
                self.didSuccesLogout?()
            case .failure(let error):
                self.showWarningToast?(error.localizedDescription)
            }
        }
    }
}
