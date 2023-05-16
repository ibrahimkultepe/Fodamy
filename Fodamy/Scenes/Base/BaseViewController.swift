//
//  BaseViewController.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 26.02.2023.
//

import UIKit

class BaseViewController<V: BaseViewModelProtocol>: UIViewController, BaseViewController.LoadingProtocols {
    
    typealias LoadingProtocols = LoadingProtocol & ActivityIndicatorProtocol
    
    var tryAgainErrorButton = UIButtonBuilder()
        .titleColor(.appWhite)
        .titleFont(.font(.nunitoBold, size: .xxLarge))
        .build()
    
    var viewModel: V
    
    @objc
    func tryAgainButtonTapped() {
        viewModel.tryAgainButtonTapped()
    }
    
    init(viewModel: V) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addTryAgainButton()
        subscribeShowTryAgainButton()
        subscribeHideTryAgainButton()
        subscribeActivityIndicatorView()
        subscribeLoading()
        subscribeToast()
    }
}

extension BaseViewController {
    
    func addTryAgainButton() {
        view.addSubview(tryAgainErrorButton)
        tryAgainErrorButton.centerInSuperview()
        tryAgainErrorButton.backgroundColor = .appRed
        tryAgainErrorButton.size(CGSize(width: 200, height: 50))
        tryAgainErrorButton.setTitle(L10n.Base.errorButtonTitle, for: .normal)
        tryAgainErrorButton.addTarget(self, action: #selector(tryAgainButtonTapped), for: .touchUpInside)
    }
    
    func subscribeShowTryAgainButton() {
        viewModel.showTryAgainButton = { [weak self] in
            self?.addTryAgainButton()
        }
    }
    
    func subscribeHideTryAgainButton() {
        viewModel.hideTryAgainButton = { [weak self] in
            self?.tryAgainErrorButton.removeFromSuperview()
        }
    }

    func subscribeActivityIndicatorView() {
        viewModel.hideActivityIndicatorView = { [weak self] in
            self?.hideActivityIndicator()
        }
        viewModel.showActivityIndicatorView = { [weak self] in
            self?.showActivityIndicator()
        }
    }
    
    func subscribeLoading() {
        viewModel.hideLoading = { [weak self] in
            DispatchQueue.main.async {
                self?.dismissLoading()
            }
        }
        viewModel.showLoading = { [weak self] in
            DispatchQueue.main.async {
                self?.presentLoading()
            }
        }
    }
    
    func subscribeToast() {
        viewModel.showWarningToast = { message in
            ToastPresenter.showWarningToast(text: message)
        }
    }
}
