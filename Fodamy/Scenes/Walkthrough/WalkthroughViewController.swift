//
//  WalkthroughViewController.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 8.03.2023.
//

import UIKit

final class WalkthroughViewController: BaseViewController<WalkthroughViewModel> {
     
    
    private let vectorButton = UIButtonBuilder()
        .image(.imgVector)
        .backgroundImage(.imgVector2)
        .build()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(WalkthroughCollectionViewCell.self)
        return collectionView
    }()
    
    private let pageControl = UIPageControlBuilder()
        .pageIndicatorTintColor(.appRed.withAlphaComponent(0.2))
        .currentPageIndicatorTintColor(.appRed)
        .numberOfPages(4)
        .isUserInteractionEnabled(false)
        .build()
    
    private let nextButton = UIButtonBuilder()
        .backgroundColor(.appRed)
        .titleColor(.appWhite)
        .titleFont(.font(.nunitoBold, size: .xxLarge))
        .build()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureContent()
        setLocalize()
    }
}

// MARK: - UILayout
extension WalkthroughViewController {
    
    private func addSubviews() {
        view.addSubview(vectorButton)
        vectorButton.edgesToSuperview(excluding: [.left, .bottom], insets: .init(top: 20.75, left: 0, bottom: 0, right: 20.75), usingSafeArea: true)
        vectorButton.height(22.5)
        vectorButton.width(22.5)
        
        view.addSubview(collectionView)
        collectionView.topToBottom(of: vectorButton).constant = 75.75
        collectionView.edgesToSuperview(excluding: [.top, .bottom] ,insets: .init(top: 0, left: 0, bottom: 0, right: 0), usingSafeArea: true)
        
        view.addSubview(pageControl)
        pageControl.topToBottom(of: collectionView)
        pageControl.centerXToSuperview()
        
        view.addSubview(nextButton)
        nextButton.topToBottom(of: pageControl).constant = 20
        nextButton.height(62)
        nextButton.edgesToSuperview(excluding: .top, insets: .init(top: 0, left: 20, bottom: 11, right: 20), usingSafeArea: true)
    }
}

// MARK: - ConfigureContent
extension WalkthroughViewController {
    
    private func configureContent() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        nextButton.addTarget(self, action: #selector(nextButtonAction), for: .touchUpInside)
    }
}

// MARK: - SetLocalize
extension WalkthroughViewController {
    
    private func setLocalize() {
        nextButton.setTitle(L10n.WalkThrough.nextButtonTitle, for: .normal)
    }
}

// MARK: - Actions
extension WalkthroughViewController {
    
    @objc
    private func nextButtonAction() {
        if pageControl.currentPage == viewModel.numberOfItems - 1 {
            viewModel.didFinishWalkthrough()
        }
        
        let nextIndex = pageControl.currentPage + 1
        let indexPath = IndexPath(item: nextIndex, section: 0)
        if nextIndex < viewModel.numberOfItems {
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}

// MARK: - UIScrollViewDelegate
extension WalkthroughViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset.x
        let width = scrollView.frame.width
        let horizontalCenter = width / 2
        pageControl.currentPage = Int(offSet + horizontalCenter) / Int(width)
        
        if pageControl.currentPage == viewModel.numberOfItems - 1 {
            nextButton.setTitle(L10n.WalkThrough.startButtonTitle, for: .normal)
            vectorButton.isHidden = true
        } else {
            nextButton.setTitle(L10n.WalkThrough.nextButtonTitle, for: .normal)
            vectorButton.isHidden = false
        }
    }
}

// MARK: - UICollectionViewDataSource
extension WalkthroughViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: WalkthroughCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        let cellItem = viewModel.cellItemForAt(indexPath: indexPath)
        cell.setCellItem(viewModel: cellItem)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension WalkthroughViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: 0, right: 0)
    }
}
