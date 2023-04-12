//
//  WalkthroughCollectionViewCell.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 8.03.2023.
//

import UIKit
import TinyConstraints

class WalkthroughCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CustomCollectionViewCell"
    private var viewModel: WalkthroughCellModel?
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = .imgWalkthrough
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .appFocus
        titleLabel.font = UIFont(name: "Nunito-Bold", size: 16)
        return titleLabel
    }()
    
    private let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.textColor = .appText
        descriptionLabel.font = UIFont(name: "Nunito-Bold", size: 15)
        return descriptionLabel
    }()
    
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
extension WalkthroughCollectionViewCell {
    
    func setCellItem(viewModel: WalkthroughCellModel) {
        self.viewModel = viewModel
        self.titleLabel.text = viewModel.title
        self.descriptionLabel.text = viewModel.description
        self.imageView.image = viewModel.image
    }
}
