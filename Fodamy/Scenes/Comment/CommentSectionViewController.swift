//
//  CommentSectionViewController.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 28.06.2023.
//

import UIKit

final class CommentSectionViewController: BaseViewController<CommentSectionViewModel> {
    
    private let refreshControl = UIRefreshControl()
    
    private let collectionView = UICollectionViewBuilder()
        .backgroundColor(.appSecondaryBackground)
        .estimatedItemSize(UICollectionViewFlowLayout.automaticSize)
        .build()
    
    private let commentEntryView = CommentEntryView()
    
    private var bottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureContent()
        subscribeViewModel()
        viewModel.getRecipeComment(showLoading: true)
        sendButtonTapped()
        registerKeyboardNotifications()
    }
}

// MARK: - UILayout
extension CommentSectionViewController {
    
    private func addSubviews() {
        view.addSubview(collectionView)
        collectionView.edgesToSuperview(excluding: .bottom, usingSafeArea: true)
        
        view.addSubview(commentEntryView)
        commentEntryView.topToBottom(of: collectionView)
        commentEntryView.edgesToSuperview(excluding: .top, usingSafeArea: true)
        commentEntryView.height(52)
        
        bottomConstraint = commentEntryView.bottomToSuperview(usingSafeArea: true)
        bottomConstraint?.isActive = true
    }
}

// MARK: - ConfigureContent
extension CommentSectionViewController {
    
    private func configureContent() {
        collectionView.register(CommentCell.self)
        collectionView.registerFooter(ActivityIndicatorViewFooterView.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
}

// MARK: - Actions
extension CommentSectionViewController {
    
    @objc
    private func refreshData() {
        viewModel.refreshData()
    }
    
    private func sendButtonTapped() {
        commentEntryView.sendButtonTapped = { [weak self] text in
            guard let self = self else { return }
            self.viewModel.sendButtonTapped(commentText: text)
        }
    }
}

// MARK: - NotificationCenter
extension CommentSectionViewController {
    
    private func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShown),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillBeHidden),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc
    private func keyboardWillShown(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        
        let keyboardHeight = view.bounds.height - keyboardFrame.origin.y
        if notification.name == UIResponder.keyboardWillShowNotification {
            UIView.animate(withDuration: 0.3) { [weak self] in
                guard let self = self else { return }
                self.bottomConstraint?.constant = self.view.safeAreaInsets.bottom - keyboardHeight
                self.view.layoutIfNeeded()
            }
        }
    }

    @objc
    private func keyboardWillBeHidden(notification: Notification) {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            self.bottomConstraint?.constant = 0
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: - ScrollViewDelegate
extension CommentSectionViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let viewHeight = scrollView.frame.height
        
        if contentOffsetY > contentHeight - viewHeight && viewModel.isPagingEnabled && viewModel.isRequestEnabled {
            viewModel.getRecipeComment(showLoading: false)
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}

// MARK: - UICollectionViewDataSource
extension CommentSectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CommentCell = collectionView.dequeueReusableCell(for: indexPath)
        let cellItem = viewModel.cellItemForAt(indexPath: indexPath)
        
        cellItem.moreButtonTapped = { [weak self] in
            guard let self = self else { return }
            self.viewModel.moreButtonTapped(indexPath: indexPath, viewController: self)
        }
        
        cell.setCellItem(viewModel: cellItem)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let footer: ActivityIndicatorViewFooterView = collectionView.dequeueReusableCell(ofKind: kind, for: indexPath)
            return footer
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplaySupplementaryView view: UICollectionReusableView,
                        forElementKind elementKind: String,
                        at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter,
           let view = view as? ActivityIndicatorViewFooterView,
           viewModel.isPagingEnabled {
            view.startLoading()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didEndDisplayingSupplementaryView view: UICollectionReusableView,
                        forElementOfKind elementKind: String,
                        at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter,
           let view = view as? ActivityIndicatorViewFooterView,
           viewModel.isPagingEnabled {
            view.stopLoading()
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CommentSectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {
        let height: CGFloat = viewModel.isPagingEnabled ? 50 : 0
        return CGSize(width: collectionView.bounds.width, height: height)
    }
}

// MARK: - SubscribeViewModel
extension CommentSectionViewController {
    
    private func subscribeViewModel() {
        viewModel.getRecipeCommentDidSuccess = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
        
        viewModel.reloadData = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
        viewModel.postRecipeCommentDidSuccess = { [weak self] in
            guard let self = self else { return }
            self.commentEntryView.textViewText = ""
            let indexPath = IndexPath(item: 0, section: 0)
            self.collectionView.scrollToItem(at: indexPath, at: .top, animated: true)
            self.viewModel.postNotification()
        }
        
        viewModel.deleteRecipeCommentDidSuccess = { [weak self] indexPath in
            guard let self = self else { return }
            self.collectionView.deleteItems(at: [indexPath])
            self.collectionView.reloadData()
            self.viewModel.postNotification()
        }
    }
}
