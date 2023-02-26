//
//  ActivityIndicatorView.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 26.02.2023.
//

import UIKit

class ActivityIndicatorView: UIActivityIndicatorView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        style = .gray
        tintColor = .darkGray
        hidesWhenStopped = true
    }
}
