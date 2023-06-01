//
//  UserView.swift
//  UIComponents
//
//  Created by İbrahim Kültepe on 9.05.2023.
//

import UIKit

public class UserView: UIView {
    
    private let userImageView = UIImageViewBuilder()
        .cornerRadius(20)
        .contentMode(.scaleToFill)
        .clipsToBounds(true)
        .build()
    
    private let nameAndSurnameStackView = UIStackViewBuilder()
        .axis(.vertical)
        .build()
    
    private let userNameAndSurnameLabel = UILabelBuilder()
        .textColor(.appCinder)
        .font(.font(.nunitoSemiBold, size: .xxLarge))
        .build()
    
    private let recipeAndFollowerLabel = UILabelBuilder()
        .textColor(.appRaven)
        .font(.font(.nunitoSemiBold, size: .large))
        .build()
    
    public var userImageURL: String? {
        didSet {
            userImageView.setImage(userImageURL)
        }
    }
    
    public var userNameAndSurname: String? {
        didSet {
            userNameAndSurnameLabel.text = userNameAndSurname
        }
    }
    
    public var recipeAndFollower: String? {
        didSet {
            recipeAndFollowerLabel.text = recipeAndFollower
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
extension UserView {
    
    private func addSubviews() {
        backgroundColor = .appWhite
        addSubview(userImageView)
        userImageView.leadingToSuperview().constant = 20
        userImageView.topToSuperview(relation: .equalOrGreater)
        userImageView.bottomToSuperview(relation: .equalOrLess)
        userImageView.centerYToSuperview()
        userImageView.size(.init(width: 40, height: 40))
        
        addSubview(nameAndSurnameStackView)
        nameAndSurnameStackView.leadingToTrailing(of: userImageView).constant = 12
        nameAndSurnameStackView.centerYToSuperview()
        nameAndSurnameStackView.trailingToSuperview()
        nameAndSurnameStackView.addArrangedSubview(userNameAndSurnameLabel)
        nameAndSurnameStackView.addArrangedSubview(recipeAndFollowerLabel)
    }
}
