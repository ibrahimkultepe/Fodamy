//
//  LoginViewController.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 13.06.2023.
//

import UIKit

final class LoginViewController: BaseViewController<LoginViewModel> {
    
    private let dismissButton = UIButtonBuilder()
        .image(.imgVector)
        .tintColor(.appCinder)
        .backgroundImage(.imgVector2)
        .build()
    
    private let titleLabel = UILabelBuilder()
        .font(.font(.nunitoBold, size: .xxLarge))
        .textAlignment(.center)
        .build()
    
    private let stackView = UIStackViewBuilder()
        .axis(.vertical)
        .distribution(.fillEqually)
        .spacing(20)
        .build()
    
    private let userNameTextField = AuthTextField()
    private let passwordTextField = AuthTextField()
    
    private let loginButton = UIButtonBuilder()
        .backgroundColor(.appHeather)
        .titleColor(.appSecondaryBackground)
        .titleFont(.font(.nunitoBold, size: .xxLarge))
        .build()
    
    private let forgotPasswordButton = UIButtonBuilder()
        .backgroundColor(.clear)
        .titleColor(.appHeather)
        .titleFont(.font(.nunitoBold, size: .small))
        .build()
    
    private let bottomStackView = UIStackViewBuilder()
        .spacing(10)
        .axis(.horizontal)
        .build()
    
    private let bottomLabel = UILabelBuilder()
        .font(.font(.nunitoSemiBold, size: .large))
        .textColor(.appRaven)
        .build()
    
    private let signUpButton = UIButtonBuilder()
        .titleColor(.appRed)
        .titleFont(.font(.nunitoSemiBold, size: .large))
        .build()

    private let validation = Validation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureContent()
        setLocalize()
    }
}

// MARK: - UILayout
extension LoginViewController {
    
    private func addSubviews() {
        view.addSubview(dismissButton)
        dismissButton.edgesToSuperview(excluding: [.left, .bottom], insets: .init(top: 64, left: 0, bottom: 0, right: 20))
        dismissButton.height(24)
        dismissButton.width(24)
        
        view.addSubview(titleLabel)
        titleLabel.topToBottom(of: dismissButton).constant = 75.75
        titleLabel.edgesToSuperview(excluding: [.top, .bottom], insets: .init(top: 44, left: 0, bottom: 0, right: 0), usingSafeArea: true)
        titleLabel.height(22)
        
        view.addSubview(stackView)
        stackView.topToBottom(of: titleLabel).constant = 32
        stackView.edgesToSuperview(excluding: [.top, .bottom], insets: .init(top: 0, left: 20, bottom: 0, right: 20))
        stackView.addArrangedSubview(userNameTextField)
        stackView.addArrangedSubview(passwordTextField)
        
        view.addSubview(loginButton)
        loginButton.topToBottom(of: stackView).constant = 32
        loginButton.edgesToSuperview(excluding: [.top, .bottom], insets: .init(top: 0, left: 20, bottom: 0, right: 20))
        loginButton.height(58)
        
        view.addSubview(forgotPasswordButton)
        forgotPasswordButton.topToBottom(of: loginButton).constant = 12
        forgotPasswordButton.edgesToSuperview(excluding: [.top, .bottom], insets: .init(top: 0, left: 20, bottom: 0, right: 20))
        forgotPasswordButton.height(16)
        
        view.addSubview(bottomStackView)
        bottomStackView.centerXToSuperview()
        bottomStackView.leadingToSuperview(relation: .equalOrGreater)
        bottomStackView.trailingToSuperview(relation: .equalOrLess)
        bottomStackView.bottomToSuperview(usingSafeArea: true)
        bottomStackView.addArrangedSubview(bottomLabel)
        bottomStackView.addArrangedSubview(signUpButton)
    }
}

// MARK: - ConfigureContent
extension LoginViewController {
    
    private func configureContent() {
        signUpButton.addTarget(self, action: #selector(signUpButtonAction), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
        dismissButton.addTarget(self, action: #selector(vectorButtonAction), for: .touchUpInside)
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordButtonAction), for: .touchUpInside)
        passwordTextField.isSecureTextEntry = true
        userNameTextField.iconImage = .icUser
        passwordTextField.iconImage = .icPassword
        forgotPasswordButton.contentHorizontalAlignment = .right
    }
}

// MARK: - SetLocalize
extension LoginViewController {
    
    private func setLocalize() {
        titleLabel.text = L10n.Login.titleLabel
        userNameTextField.title = L10n.Login.userNameTextField
        passwordTextField.title = L10n.Login.passwordTextField
        signUpButton.setTitle(L10n.Login.signUpButton, for: .normal)
        bottomLabel.text = L10n.Login.bottomLabel
        loginButton.setTitle(L10n.Login.loginButton, for: .normal)
        forgotPasswordButton.setTitle(L10n.Login.forgotPasswordButton, for: .normal)
    }
}

// MARK: - Actions
extension LoginViewController {
    
    @objc
    private func loginButtonAction() {
        guard
            let userName = userNameTextField.text,
            let password = passwordTextField.text
        else { return }
        
        guard validation.isValidName(userName) else { return }
        guard validation.isValidPassword(password) else { return }
        
        viewModel.loginRequest(userName: userName, password: password)
    }
    
    @objc
    private func signUpButtonAction() {
        viewModel.pushRegisterVC()
    }
    
    @objc
    private func forgotPasswordButtonAction() {
        viewModel.pushForgotPasswordVC()
    }
    
    @objc
    private func vectorButtonAction() {
        viewModel.dismissButtonTapped()
    }
}
