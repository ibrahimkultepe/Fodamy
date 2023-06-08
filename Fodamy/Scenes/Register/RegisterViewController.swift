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
        .spacing(20)
        .build()
    
    private let userNameTextField = RegisterTextField()
    private let emailTextField = RegisterTextField()
    private let passwordTextField = RegisterTextField()
    
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
        bottomStackView.topToBottom(of: signUpButton).constant = 190
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
        titleLabel.backgroundColor = .cyan
        stackView.backgroundColor = .yellow
        userNameTextField.backgroundColor = .red

        
        
        
        
        titleLabel.text = "Üye Ol"
        signUpButton.setTitle("Üye Ol", for: .normal)
        
        userNameTextField.title = "Kullanıcı Adı"
        userNameTextField.iconImage = .icUser
        
        emailTextField.title = "E-Mail Adresi"
        emailTextField.iconImage = .icMail

        passwordTextField.title = "Şifre"
        userNameTextField.iconImage = .icPassword
        
        bottomLabel.text = "Hesabın mı var ?"
    
        
        loginButton.setTitle("Giriş yap", for: .normal)
    }
}
