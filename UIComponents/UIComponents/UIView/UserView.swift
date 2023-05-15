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
    
    private let verticalStackView = UIStackViewBuilder()
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
        addSubview(userImageView)
        userImageView.edgesToSuperview(excluding: .right ,insets: .init(top: 0, left: 10, bottom: 20.5, right: 0))
        userImageView.size(.init(width: 40, height: 40))
        
        addSubview(verticalStackView)
        verticalStackView.leadingToTrailing(of: userImageView).constant = 12
        verticalStackView.edgesToSuperview(excluding: .leading, insets: .init(top: 0, left: 0, bottom: 12, right: 20))
        verticalStackView.addArrangedSubview(userNameAndSurnameLabel)
        verticalStackView.addArrangedSubview(recipeAndFollowerLabel)
    }
}
