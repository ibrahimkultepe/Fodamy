//
//  UserView.swift
//  UIComponents
//
//  Created by İbrahim Kültepe on 9.05.2023.
//

public class UserView: UIView {
    
    private let userImageView = UIImageViewBuilder()
        .cornerRadius(20)
        .contentMode(.scaleToFill)
        .clipsToBounds(true)
        .image(.imgWalkthrough1)
        .build()
    
    private let verticalStackView = UIStackViewBuilder()
        .axis(.vertical)
        .build()
    
    private let userNameLabel = UILabelBuilder()
        .textColor(.appCinder)
        .font(.font(.nunitoSemiBold, size: .xxLarge))
        .text("İbrahim Kültepe")
        .build()
    
    private let recipeAndFollowerLabel = UILabelBuilder()
        .textColor(.appRaven)
        .font(.font(.nunitoSemiBold, size: .large))
        .text("999 Tarif 72 Takipçi")
        .build()
    
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
        verticalStackView.addArrangedSubview(userNameLabel)
        verticalStackView.addArrangedSubview(recipeAndFollowerLabel)
    }
}
