//
//  RecipeDetailCommentAndLikeView.swift
//  UIComponents
//
//  Created by İbrahim Kültepe on 31.05.2023.
//

import UIKit

public class RecipeDetailCommentAndLikeView: UIView {
    
    private let iconButton = UIButtonBuilder()
        .tintColor(.appCinder)
        .build()
    
    private let stackView = UIStackViewBuilder()
        .axis(.horizontal)
        .spacing(3)
        .build()
    
    private let numberLabel = UILabelBuilder()
        .textColor(.appRed)
        .font(.font(.nunitoSemiBold, size: .xSmall))
        .textAlignment(.center)
        .build()
    
    private let infoLabel = UILabelBuilder()
        .textColor(.appRaven)
        .font(.font(.nunitoSemiBold, size: .xSmall))
        .textAlignment(.center)
        .build()
    
    public var iconOfButton: UIImage? {
        didSet {
            iconButton.setImage(iconOfButton, for: .normal)
        }
    }
    
    public var number: Int? {
        didSet {
            numberLabel.text = "\(number ?? 1)"
        }
    }
    
    public var info: String? {
        didSet {
            infoLabel.text = info
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
extension RecipeDetailCommentAndLikeView {
    
    private func addSubviews() {
        backgroundColor = .appWhite
        addSubview(iconButton)
        iconButton.centerXToSuperview()
        iconButton.size(.init(width: 17, height: 15))
        iconButton.topToSuperview().constant = 7
        iconButton.leadingToSuperview(relation: .equalOrGreater)
        iconButton.trailingToSuperview(relation: .equalOrLess)
        
        addSubview(stackView)
        stackView.topToBottom(of: iconButton).constant = 7
        stackView.centerXToSuperview()
        stackView.leadingToSuperview(relation: .equalOrGreater)
        stackView.trailingToSuperview(relation: .equalOrLess)
        stackView.bottomToSuperview().constant = -4
        
        stackView.addArrangedSubview(numberLabel)
        stackView.addArrangedSubview(infoLabel)
    }
}
