//
//  CommentCell.swift
//  UIComponents
//
//  Created by İbrahim Kültepe on 6.06.2023.
//

import UIKit

public class CommentCell: UICollectionViewCell, ReusableView {
    
    weak var viewModel: CommentCellModelProtocol?
    
    private let userView = UserView()
    
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
        .build()
    
    private lazy var width: NSLayoutConstraint = {
          let width = contentView.widthAnchor.constraint(equalToConstant: bounds.size.width)
          width.isActive = true
          return width
      }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
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
        contentView.addSubview(userView)
        userView.edgesToSuperview(excluding: .bottom)
        userView.height(65)
        
        contentView.addSubview(stackView)
        stackView.topToBottom(of: userView)
        stackView.edgesToSuperview(excluding: .top, insets: .init(top: 0, left: 20, bottom: 8, right: 20))
        stackView.addArrangedSubview(differenceLabel)
        stackView.addArrangedSubview(commentLabel)
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
    }
}
