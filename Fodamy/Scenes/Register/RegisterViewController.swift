//
//  RegisterViewController.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 5.06.2023.
//

import UIKit

final class RegisterViewController: BaseViewController<RegisterViewModel> {
    
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
    private let emailTextField = AuthTextField()
    private let passwordTextField = AuthTextField()
    
    private let signUpButton = UIButtonBuilder()
        .backgroundColor(.appHeather)
        .titleColor(.appSecondaryBackground)
        .titleFont(.font(.nunitoBold, size: .xxLarge))
        .build()
    
    private let bottomStackView = UIStackViewBuilder()
        .spacing(10)
        .axis(.horizontal)
        .build()
    
    private let bottomLabel = UILabelBuilder()
        .font(.font(.nunitoSemiBold, size: .large))
        .textColor(.appRaven)
        .build()
    
    private let loginButton = UIButtonBuilder()
        .titleColor(.appRed)
        .titleFont(.font(.nunitoSemiBold, size: .large))
        .build()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureContent()
        setLocalize()
    }
}

// MARK: - UILayout
extension RegisterViewController {
    
    private func addSubviews() {
        view.addSubview(titleLabel)
        titleLabel.edgesToSuperview(excluding: .bottom, insets: .init(top: 63, left: 0, bottom: 0, right: 0), usingSafeArea: true)
        titleLabel.height(22)
        
        view.addSubview(stackView)
        stackView.topToBottom(of: titleLabel).constant = 32
        stackView.edgesToSuperview(excluding: [.top, .bottom], insets: .init(top: 0, left: 20, bottom: 0, right: 20))
        stackView.addArrangedSubview(userNameTextField)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        
        view.addSubview(signUpButton)
        signUpButton.topToBottom(of: stackView).constant = 32
        signUpButton.edgesToSuperview(excluding: [.top, .bottom], insets: .init(top: 0, left: 20, bottom: 0, right: 20))
        signUpButton.height(58)
        
        view.addSubview(bottomStackView)
        bottomStackView.centerXToSuperview()
        bottomStackView.leadingToSuperview(relation: .equalOrGreater)
        bottomStackView.trailingToSuperview(relation: .equalOrLess)
        bottomStackView.bottomToSuperview(usingSafeArea: true)
        bottomStackView.addArrangedSubview(bottomLabel)
        bottomStackView.addArrangedSubview(loginButton)
    }
}

// MARK: - ConfigureContent
extension RegisterViewController {
    
    private func configureContent() {
        
    }
}

// MARK: - SetLocalize
extension RegisterViewController {
    
    private func setLocalize() {
        titleLabel.text = L10n.Register.titleLabel
        userNameTextField.title = L10n.Register.userNameTextField
        userNameTextField.iconImage = .icUser
        emailTextField.title = L10n.Register.emailTextField
        emailTextField.iconImage = .icMail
        passwordTextField.title = L10n.Register.passwordTextField
        passwordTextField.iconImage = .icPassword
        signUpButton.setTitle(L10n.Register.signUpButton, for: .normal)
        bottomLabel.text = L10n.Register.bottomLabel
        loginButton.setTitle(L10n.Register.loginButton, for: .normal)
    }
}

// MARK: - Actions
extension RegisterViewController {
    
}
