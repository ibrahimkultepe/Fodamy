//
//  AuthTextField.swift
//  UIComponents
//
//  Created by İbrahim Kültepe on 8.06.2023.
//

import UIKit

public class AuthTextField: UITextField {
    
    private let titleLabel = UILabelBuilder()
        .font(.font(.nunitoSemiBold, size: .xxLarge))
        .textColor(.appRaven)
        .build()
    
    private let iconImageView = UIImageViewBuilder()
        .tintColor(.appCinder)
        .contentMode(.scaleAspectFit)
        .build()
    
    public var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    public var iconImage: UIImage? {
        didSet {
            iconImageView.image = iconImage
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        configureContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let labelTopMargin: CGFloat = 10
    private let margin = UIEdgeInsets(top: 31, left: 56, bottom: 9, right: 26)
    
    @objc
    private func textFieldDidBeginEditing() {
        UIView.animate(withDuration: 0.3) {
            self.titleLabel.transform = CGAffineTransform(translationX: 0, y: -self.labelTopMargin)
            self.titleLabel.textColor = .appRed
        }
    }
    
    @objc
    private func textFieldDidEndEditing() {
        UIView.animate(withDuration: 0.3) {
            if self.text?.isEmpty == true {
                self.titleLabel.transform = .identity
                self.titleLabel.textColor = .appRaven
            }
        }
    }

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: margin)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: margin)
    }
}

// MARK: - UILayout
extension AuthTextField {
    
    private func addSubviews() {
        height(60)
        addSubview(iconImageView)
        iconImageView.leadingToSuperview().constant = 23
        iconImageView.centerYToSuperview()
        iconImageView.size(.init(width: 18, height: 18))
        
        addSubview(titleLabel)
        titleLabel.leadingToTrailing(of: iconImageView).constant = 15
        titleLabel.centerYToSuperview()
        titleLabel.trailingToSuperview().constant = -20
        titleLabel.height(22)
    }
}

// MARK: - ConfigureContent
extension AuthTextField {
    
    private func configureContent() {
        font = UIFont.font(.nunitoSemiBold, size: .large)
        layer.borderColor = UIColor.appHeather.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 8
        clipsToBounds = true
        addTarget(self, action: #selector(textFieldDidBeginEditing), for: .editingDidBegin)
        addTarget(self, action: #selector(textFieldDidEndEditing), for: .editingDidEnd)
        autocorrectionType = .no
    }
}
