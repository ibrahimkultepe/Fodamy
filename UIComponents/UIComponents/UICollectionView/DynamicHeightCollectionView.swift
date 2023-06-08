//
//  DynamicHeightCollectionView.swift
//  UIComponents
//
//  Created by İbrahim Kültepe on 6.06.2023.
//

public final class DynamicHeightCollectionView: UICollectionView {
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        if !(__CGSizeEqualToSize(bounds.size, self.intrinsicContentSize)) {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    public override var intrinsicContentSize: CGSize {
        return contentSize
    }
}
