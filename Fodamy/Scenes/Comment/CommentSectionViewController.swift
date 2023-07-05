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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureContent()
        subscribeViewModel()
        viewModel.getRecipeComment()
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
            commentEntryView.frame.origin.y = view.bounds.height - keyboardHeight - commentEntryView.frame.height
        }
    }

    @objc
    private func keyboardWillBeHidden(notification: Notification) {
        commentEntryView.frame.origin.y = view.bounds.height - commentEntryView.frame.height - view.safeAreaInsets.bottom
    }
}

// MARK: - ScrollViewDelegate
extension CommentSectionViewController {
    
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
        cell.setCellItem(viewModel: cellItem)
        return cell
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
        }
    }
}
