//
//  CommentEntryView.swift
//  UIComponents
//
//  Created by İbrahim Kültepe on 3.07.2023.
//

import MobilliumBuilders
import UIKit

public class CommentEntryView: UIView {
    
    private let textView = UITextViewBuilder()
        .backgroundColor(.appWhite)
        .font(.font(.nunitoSemiBold, size: .xLarge))
        .textColor(.appRaven)
        .borderWidth(2)
        .borderColor(UIColor.appZircon.cgColor)
        .cornerRadius(24)
        .textContainerInset(UIEdgeInsets(top: 7, left: 12, bottom: 7, right: 12))
        .text(L10n.CommentEntryView.textViewText)
        .build()
    
    private let sendButton = UIButtonBuilder()
        .cornerRadius(18)
        .clipsToBounds(true)
        .image(UIImage.icSend.withRenderingMode(.alwaysTemplate))
        .tintColor(.appWhite)
        .backgroundColor(.gray)
        .build()
    
    public var textViewText: String? {
        didSet {
            textView.text = textViewText
        }
    }
    
    public var sendButtonTapped: StringClosure?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        configureContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UILayout
extension CommentEntryView {
    
    private func addSubviews() {
        backgroundColor = .appWhite
        addSubview(textView)
        textView.centerYToSuperview()
        textView.leadingToSuperview().constant = 16
        textView.height(34)
        
        addSubview(sendButton)
        sendButton.leadingToTrailing(of: textView).constant = 20
        sendButton.centerYToSuperview()
        sendButton.trailingToSuperview().constant = -16
        sendButton.size(.init(width: 36, height: 36))
    }
}

// MARK: - ConfigureContent
extension CommentEntryView {
    
    private func configureContent() {
        sendButton.addTarget(self, action: #selector(sendButtonAction), for: .touchUpInside)
        textView.delegate = self
    }
}

// MARK: - Actions
extension CommentEntryView {
    
    @objc
    private func sendButtonAction() {
        textViewText = textView.text
        sendButtonTapped?(textViewText ?? "")
    }
}

// MARK: - UITextViewDelegate
extension CommentEntryView: UITextViewDelegate {
    
    public func textViewDidChange(_ textView: UITextView) {
        if textView.text.isEmpty {
            sendButton.backgroundColor = .gray
        } else {
            sendButton.backgroundColor = .red
        }
    }
    
    public func textViewDidBeginEditing(_ textView: UITextView) {
            textView.text = ""
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = L10n.CommentEntryView.textViewText
        }
    }
}
