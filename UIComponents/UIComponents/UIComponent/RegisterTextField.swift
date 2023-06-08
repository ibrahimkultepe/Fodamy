//
//  RegisterTextField.swift
//  UIComponents
//
//  Created by İbrahim Kültepe on 8.06.2023.
//

import UIKit
import MobilliumBuilders

public class RegisterTextField: UITextField {
    
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UILayout
extension RegisterTextField {
    
    private func addSubviews() {
        addSubview(iconImageView)
        iconImageView.leadingToSuperview().constant = 23
        iconImageView.centerYToSuperview()
        
        addSubview(titleLabel)
        titleLabel.leadingToTrailing(of: iconImageView).constant = 15
        titleLabel.centerYToSuperview()
        titleLabel.trailingToSuperview().constant = -20
    }
}
