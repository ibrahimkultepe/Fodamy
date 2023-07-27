//
//  CommentEditViewController.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 13.07.2023.
//

import UIKit

final class CommentEditViewController: BaseViewController<CommentEditViewModel> {
    
    private let commentTextView = UITextViewBuilder()
        .backgroundColor(.appWhite)
        .font(.font(.nunitoSemiBold, size: .xLarge))
        .textColor(.appRaven)
        .build()
    
    private let saveButton = UIButtonBuilder()
        .titleFont(.font(.nunitoBold, size: .xxLarge))
        .titleColor(.appWhite)
        .backgroundColor(.appRed)
        .build()
    
    private var bottomConstraint: NSLayoutConstraint?
    
    private let padding = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureContent()
        setLocalize()
        registerKeyboardNotifications()
    }
}

// MARK: - UILayout
extension CommentEditViewController {
    
    private func addSubviews() {
        view.addSubview(commentTextView)
        commentTextView.edgesToSuperview(excluding: .bottom, usingSafeArea: true)
        
        view.addSubview(saveButton)
        saveButton.topToBottom(of: commentTextView)
        saveButton.bottomToSuperview(usingSafeArea: true)
        saveButton.centerXToSuperview()
        saveButton.size(.init(width: 150, height: 50))
        
        bottomConstraint = saveButton.bottomToSuperview(usingSafeArea: true)
        bottomConstraint?.isActive = true
    }
}

// MARK: - ConfigureContent
extension CommentEditViewController {
    
    private func configureContent() {
        saveButton.addTarget(self, action: #selector(saveButtonAction), for: .touchUpInside)
        commentTextView.text = viewModel.commentText
        commentTextView.textContainerInset = padding
    }
}

// MARK: - SetLocalize
extension CommentEditViewController {
    
    private func setLocalize() {
        saveButton.setTitle(L10n.CommentEditViewController.saveButtonTitle, for: .normal)
        navigationItem.title = L10n.CommentEditViewController.navigationTitle
        navigationController?.navigationBar.topItem?.backButtonTitle = L10n.NavigationController.backButtonTitle
    }
}

// MARK: - Actions
extension CommentEditViewController {
    
    @objc
    private func saveButtonAction() {
        guard let commentText = commentTextView.text, !commentText.isEmpty else {
            ToastPresenter.showWarningToast(text: L10n.CommentEditViewController.showWarningToast)
            return
        }
        viewModel.editComment(commentText: commentText)
    }
}

// MARK: - NotificationCenter
extension CommentEditViewController {
    
    private func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShown),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillBeHidden),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc
    private func keyboardWillShown(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        
        let keyboardHeight = view.bounds.height - keyboardFrame.origin.y
        if notification.name == UIResponder.keyboardWillShowNotification {
            UIView.animate(withDuration: 0.3) { [weak self] in
                guard let self = self else { return }
                self.bottomConstraint?.constant = self.view.safeAreaInsets.bottom - keyboardHeight - 20
                self.view.layoutIfNeeded()
            }
        }
    }

    @objc
    private func keyboardWillBeHidden(notification: Notification) {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            self.bottomConstraint?.constant = 0
            self.view.layoutIfNeeded()
        }
    }
}
