//
//  ForgotPasswordViewController.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 16.06.2023.
//

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
    }
}

// MARK: - UILayout
extension ForgotPasswordViewController {
    
    private func addSubviews() {
        view.addSubview(titleLabel)
        titleLabel.edgesToSuperview(excluding: .bottom, insets: .top(44), usingSafeArea: true)
        titleLabel.height(22)
        
        view.addSubview(stackView)
        stackView.topToBottom(of: titleLabel).constant = 32
        stackView.edgesToSuperview(excluding: [.top, .bottom], insets: .left(20) + .right(20))
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
