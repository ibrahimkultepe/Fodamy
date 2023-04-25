//
//  WalkthroughCollectionViewCell.swift
//  UIComponents
//
//  Created by İbrahim Kültepe on 20.04.2023.
//

import UIKit

public class WalkthroughCollectionViewCell: UICollectionViewCell, ReusableView {
    
    weak var viewModel: WalkthroughCellModelProtocol?
    
    private let imageView = UIImageViewBuilder()
        .contentMode(.scaleAspectFit)
        .image(.imgWalkthrough1)
        .build()
    
    private let titleLabel = UILabelBuilder()
        .textColor(.appCinder)
        .font(.font(.nunitoBold, size: .xxLarge))
        .build()
    
    private let descriptionLabel = UILabelBuilder()
        .textColor(.appRaven)
        .font(.font(.nunitoBold, size: .xLarge))
        .build()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        configureContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UILayout
extension WalkthroughCollectionViewCell {
    
    private func addSubviews() {
        contentView.addSubview(imageView)
        imageView.edgesToSuperview(excluding: .bottom, insets: .init(top: 0, left: 40.5, bottom: 0, right: 40.5))
        
        contentView.addSubview(titleLabel)
        titleLabel.topToBottom(of: imageView).constant = 60
        titleLabel.edgesToSuperview(excluding: [.bottom, .top], insets: .init(top: 0, left: 20, bottom: 0, right: 20))
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.topToBottom(of: titleLabel).constant = 12
        descriptionLabel.edgesToSuperview(excluding: .top, insets: .init(top: 0, left: 20, bottom: 94, right: 20))
    }
}

// MARK: - ConfigureContent
extension WalkthroughCollectionViewCell {
    
    private func configureContent() {
        titleLabel.textAlignment = .center
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
    }
}

//MARK: - SetCellItem
public extension WalkthroughCollectionViewCell {
    
    func setCellItem(viewModel: WalkthroughCellModelProtocol) {
        self.viewModel = viewModel
        self.titleLabel.text = viewModel.title
        self.descriptionLabel.text = viewModel.description
        self.imageView.image = viewModel.image
    }
}
