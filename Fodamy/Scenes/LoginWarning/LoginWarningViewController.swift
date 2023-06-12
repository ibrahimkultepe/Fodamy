//
//  LoginWarningViewController.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 12.06.2023.
//

import UIKit

final class LoginWarningViewController: BaseViewController<LoginWarningViewModel> {
    
    private let contentView = UIViewBuilder()
        .backgroundColor(.appWhite)
        .build()
    
    private let warningImageView = UIImageViewBuilder()
        .tintColor(.appYellow)
        .contentMode(.scaleToFill)
        .cornerRadius(22.5)
        .clipsToBounds(true)
        .build()
    
    private let warningLabel = UILabelBuilder()
        .textColor(.appCinder)
        .font(.font(.nunitoSemiBold, size: .xxLarge))
        .textAlignment(.center)
        .build()
    
    private let buttonStackView = UIStackViewBuilder()
        .axis(.horizontal)
        .distribution(.fillEqually)
        .build()
    
    private let loginButton = UIButtonBuilder()
        .titleFont(.font(.nunitoBold, size: .xxLarge))
        .titleColor(.appWhite)
        .backgroundColor(.appRed)
        .build()
    
    private let giveUpButton = UIButtonBuilder()
        .titleFont(.font(.nunitoBold, size: .xxLarge))
        .titleColor(.appSecondaryBackground)
        .backgroundColor(.appHeather)
        .build()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureContent()
        setLocalize()
    }
}

// MARK: - UILayout
extension LoginWarningViewController {
    
    private func addSubviews() {
        view.addSubview(contentView)
        contentView.centerYToSuperview()
        contentView.leadingToSuperview().constant = 20
        contentView.trailingToSuperview().constant = -20
        
        contentView.addSubview(warningImageView)
        warningImageView.centerXToSuperview()
        warningImageView.topToSuperview().constant = 40
        warningImageView.size(.init(width: 45, height: 45))
        
        contentView.addSubview(warningLabel)
        warningLabel.topToBottom(of: warningImageView).constant = 19
        warningLabel.edgesToSuperview(excluding: [.top, .bottom])
        
        contentView.addSubview(buttonStackView)
        buttonStackView.topToBottom(of: warningLabel).constant = 33
        buttonStackView.edgesToSuperview(excluding: .top)

        buttonStackView.addArrangedSubview(giveUpButton)
        giveUpButton.height(58)
        buttonStackView.addArrangedSubview(loginButton)
        loginButton.height(58)
    }
}

// MARK: - ConfigureContent
extension LoginWarningViewController {
    
    private func configureContent() {
        view.backgroundColor = UIColor.clear.withAlphaComponent(0.50)
        view.isOpaque = false
        warningImageView.image = .icWarning.withRenderingMode(.alwaysTemplate)
        giveUpButton.addTarget(self, action: #selector(giveUpButtonAction), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
    }
}

// MARK: - SetLocalize
extension LoginWarningViewController {
    
    private func setLocalize() {
        warningLabel.text = L10n.LoginWarning.warningLabel
        giveUpButton.setTitle(L10n.LoginWarning.giveUpButton, for: .normal)
        loginButton.setTitle(L10n.LoginWarning.loginButton, for: .normal)
    }
}

// MARK: - Actions
extension LoginWarningViewController {
    
    @objc
    private func giveUpButtonAction() {
        viewModel.giveUpButtonAction()
    }
    
    @objc
    private func loginButtonAction() {
        
    }
}
