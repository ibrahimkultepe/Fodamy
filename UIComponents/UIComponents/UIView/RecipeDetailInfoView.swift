//
//  RecipeDetailInfoView.swift
//  UIComponents
//
//  Created by İbrahim Kültepe on 5.06.2023.
//

import UIKit

public class RecipeDetailInfoView: UIView {

    private let topContainerView = UIView()
    
    private let titleLabel = UILabelBuilder()
        .font(.font(.nunitoBold, size: .xLarge))
        .build()
    
    private let stackView = UIStackViewBuilder()
        .axis(.horizontal)
        .spacing(15)
        .build()
    
    private let iconButton = UIButtonBuilder()
        .tintColor(.appCinder)
        .build()
    
    private let iconLabel = UILabelBuilder()
        .font(.font(.nunitoSemiBold, size: .medium))
        .build()
    
    private let seperator = UIViewBuilder()
        .backgroundColor(.appZircon)
        .build()
    
    private let infoLabel = UILabelBuilder()
        .font(.font(.nunitoSemiBold, size: .xLarge))
        .numberOfLines(0)
        .build()
    
    public var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    public var iconOfButton: UIImage? {
        didSet {
            iconButton.setImage(iconOfButton, for: .normal)
        }
    }
    
    public var iconText: String? {
        didSet {
            iconLabel.text = iconText
        }
    }
    
    public var infoText: String? {
        didSet {
            infoLabel.text = infoText
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
extension RecipeDetailInfoView {
    
    private func addSubviews() {
        backgroundColor = .appWhite
        addSubview(topContainerView)
        topContainerView.edgesToSuperview(excluding: .bottom)
        topContainerView.height(65)

        topContainerView.addSubview(titleLabel)
        titleLabel.leadingToSuperview().constant = 20
        titleLabel.centerYToSuperview()

        topContainerView.addSubview(stackView)
        stackView.leadingToTrailing(of: titleLabel).constant = 10
        stackView.trailingToSuperview().constant = -20
        stackView.centerYToSuperview()
        stackView.addArrangedSubview(iconButton)
        iconButton.size(.init(width: 17, height: 18))
        stackView.addArrangedSubview(iconLabel)

        addSubview(seperator)
        seperator.topToBottom(of: topContainerView)
        seperator.edgesToSuperview(excluding: [.top, .bottom])
        seperator.height(1)

        addSubview(infoLabel)
        infoLabel.topToBottom(of: seperator).constant = 12
        infoLabel.edgesToSuperview(excluding: .top, insets: .init(top: 0, left: 20, bottom: 12, right: 20))
    }
}
