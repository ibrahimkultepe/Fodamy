//
//  ForgotPasswordViewController.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 16.06.2023.
//

import UIKit

final class ForgotPasswordViewController: BaseViewController<ForgotPasswordViewModel> {
    
    private let titleLabel = UILabelBuilder()
        .font(.font(.nunitoBold, size: .xxLarge))
        .textAlignment(.center)
        .build()
    
    private let stackView = UIStackViewBuilder()
        .axis(.vertical)
        .distribution(.fillEqually)
        .spacing(32)
        .build()
    
    private let emailTextField = AuthTextField()

    private let resetPasswordButton = UIButtonBuilder()
        .backgroundColor(.appHeather)
        .titleColor(.appSecondaryBackground)
        .titleFont(.font(.nunitoBold, size: .xxLarge))
        .build()
    
    private let validation = Validation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureContent()
        setLocalize()
        subscribeViewModel()
    }
}

// MARK: - UILayout
extension ForgotPasswordViewController {
    
    private func addSubviews() {
        view.addSubview(titleLabel)
        titleLabel.edgesToSuperview(excluding: .bottom, insets: .init(top: 44, left: 0, bottom: 0, right: 0), usingSafeArea: true)
        titleLabel.height(22)
        
        view.addSubview(stackView)
        stackView.topToBottom(of: titleLabel).constant = 32
        stackView.edgesToSuperview(excluding: [.top, .bottom], insets: .init(top: 0, left: 20, bottom: 0, right: 20))
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(resetPasswordButton)
        resetPasswordButton.height(58)
    }
}

// MARK: - ConfigureContent
extension ForgotPasswordViewController {
    
    private func configureContent() {
        resetPasswordButton.addTarget(self, action: #selector(resetPasswordAction), for: .touchUpInside)
        emailTextField.iconImage = .icMail
        emailTextField.autocapitalizationType = .none
    }
    
    private func showAlert() {
        let alertController = UIAlertController(title: L10n.ForgotPassword.alertControllerTitle, message: L10n.ForgotPassword.alertControllerMesssage, preferredStyle: .alert)
        
        let acceptAction = UIAlertAction(title: L10n.ForgotPassword.alertControllerAcceptAction, style: .default) { (_) in
            self.viewModel.dismissVC()
          }
        
        alertController.addAction(acceptAction)
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - SetLocalize
extension ForgotPasswordViewController {
    
    private func setLocalize() {
        titleLabel.text = L10n.ForgotPassword.titleLabel
        emailTextField.title = L10n.ForgotPassword.emailTextField
        resetPasswordButton.setTitle(L10n.ForgotPassword.forgotPasswordButton, for: .normal)
    }
}

// MARK: - Actions
extension ForgotPasswordViewController {
    
    @objc
    private func resetPasswordAction() {
        guard let email = emailTextField.text else { return }
        guard validation.isValidEmail(email) else { return }

        viewModel.forgotPasswordRequest(email: email)
    }
}

// MARK: - SubscribeViewModel
extension ForgotPasswordViewController {
    
    private func subscribeViewModel() {
        viewModel.didSuccessPasswordReset = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.showAlert()
            }
        }
    }
}
