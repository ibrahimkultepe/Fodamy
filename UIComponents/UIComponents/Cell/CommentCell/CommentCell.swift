//
//  CommentCell.swift
//  UIComponents
//
//  Created by İbrahim Kültepe on 6.06.2023.
//

import UIKit

public class CommentCell: UICollectionViewCell, ReusableView {
    
    weak var viewModel: CommentCellModelProtocol?
    
    private let userView = UserView(followButtonStatus: .hidden)
    
    private let stackView = UIStackViewBuilder()
        .axis(.vertical)
        .build()
    
    private let differenceLabel = UILabelBuilder()
        .textColor(.appRaven)
        .font(.font(.nunitoSemiBold, size: .large))
        .build()
    
    private let commentLabel = UILabelBuilder()
        .textColor(.appCinder)
        .font(.font(.nunitoSemiBold, size: .xLarge))
        .numberOfLines(0)
        .build()
    
    private let moreButton = UIButtonBuilder()
        .backgroundColor(.clear)
        .image(UIImage.icMore.withRenderingMode(.alwaysTemplate))
        .tintColor(.appCinder)
        .build()
    
    public var isMoreButtonHidden: Bool? {
        didSet {
            moreButton.isHidden = isMoreButtonHidden ?? false
        }
    }
    
    private lazy var width: NSLayoutConstraint = {
        let width = contentView.widthAnchor.constraint(equalToConstant: bounds.size.width)
        width.isActive = true
        return width
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        configureContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func systemLayoutSizeFitting(_ targetSize: CGSize,
                                                 withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority,
                                                 verticalFittingPriority: UILayoutPriority) -> CGSize {
        width.constant = bounds.size.width
        return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 1))
    }
}

// MARK: - UILayout
extension CommentCell {
    
    private func addSubviews() {
        contentView.backgroundColor = .appWhite
        contentView.addSubview(userView)
        userView.edgesToSuperview(excluding: [.bottom, .right])
        userView.height(65)
        
        contentView.addSubview(stackView)
        stackView.topToBottom(of: userView)
        stackView.edgesToSuperview(excluding: .top, insets: .init(top: 0, left: 20, bottom: 8, right: 20))
        stackView.addArrangedSubview(differenceLabel)
        stackView.addArrangedSubview(commentLabel)
        
        contentView.addSubview(moreButton)
        moreButton.leadingToTrailing(of: userView).constant = 10
        moreButton.size(CGSize(width: 15, height: 10))
        moreButton.topToSuperview().constant = 10
        moreButton.trailingToSuperview().constant = -15
    }
}

// MARK: - ConfigureContent
extension CommentCell {
    
    private func configureContent() {
        moreButton.isHidden = true
        moreButton.addTarget(self, action: #selector(moreButtonAction), for: .touchUpInside)
    }
}

// MARK: - Actions
extension CommentCell {
    
    @objc
    private func moreButtonAction() {
        viewModel?.moreButtonTapped?()
    }
}

//MARK: - SetCellItem
public extension CommentCell {
    
    func setCellItem(viewModel: CommentCellModelProtocol) {
        self.viewModel = viewModel
        userView.userNameAndSurname = viewModel.userNameAndSurname
        userView.recipeAndFollower = viewModel.userRecipeAndFollowerCountText
        userView.userImageURL = viewModel.userImageURL
        differenceLabel.text = viewModel.difference
        commentLabel.text = viewModel.commentText
        moreButton.isHidden = !viewModel.isOwner
    }
}
