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
    
    private let followButton = UIButtonBuilder()
        .cornerRadius(6)
        .clipsToBounds(true)
        .borderColor(UIColor.appRed.cgColor)
        .borderWidth(1)
        .titleFont(.font(.nunitoSemiBold, size: .medium))
        .build()
    
    public var userImageURL: String? {
        didSet {
            if let url = userImageURL, !url.isEmpty {
                userImageView.setImage(url)
            } else {
                userImageView.image = .icUser
            }
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
    
    public var isFollowing = false {
        didSet {
            updateFollowButton()
        }
    }
    
    public var followButtonTapped: VoidClosure?
    
    private let followButtonStatus: FollowButtonStatus
    
    public enum FollowButtonStatus {
        case visible
        case hidden
    }
    
    public init(followButtonStatus: FollowButtonStatus) {
        self.followButtonStatus = followButtonStatus
        super.init(frame: .zero)
        addSubviews()
        configureContent()
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
        nameAndSurnameStackView.addArrangedSubview(userNameAndSurnameLabel)
        nameAndSurnameStackView.addArrangedSubview(recipeAndFollowerLabel)
        
        switch followButtonStatus {
        case .visible:
            addSubview(followButton)
            followButton.leadingToTrailing(of: nameAndSurnameStackView).constant = 16
            followButton.centerYToSuperview()
            followButton.trailingToSuperview().constant = -20
            followButton.size(.init(width: 91, height: 26))
            updateFollowButton()
        case .hidden:
            nameAndSurnameStackView.trailingToSuperview()
        }
    }
}

// MARK: - Configure
extension UserView {
    
    private func configureContent() {
        followButton.addTarget(self, action: #selector(followButtonAction), for: .touchUpInside)
    }
    
    private func updateFollowButton() {
        if isFollowing {
            followButton.setTitle(L10n.UserView.following, for: .normal)
            followButton.setTitleColor(.white, for: .normal)
            followButton.backgroundColor = .appRed
        } else {
            followButton.setTitle(L10n.UserView.notFollowing, for: .normal)
            followButton.setTitleColor(.appRed, for: .normal)
            followButton.backgroundColor = .appWhite
        }
    }
}

// MARK: - Actions
extension UserView {
    
    @objc
    private func followButtonAction() {
        followButtonTapped?()
    }
}
