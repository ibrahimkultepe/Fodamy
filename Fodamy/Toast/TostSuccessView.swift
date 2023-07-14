//
//  TostSuccessView.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 14.07.2023.
//

import MobilliumBuilders
import TinyConstraints

class TostSuccessView: UIView {
    
    private let label = UILabelBuilder()
        .font(.systemFont(ofSize: 15))
        .textColor(.black)
        .textAlignment(.center)
        .numberOfLines(0)
        .build()
    
    init(text: String) {
        label.text = text
        label.sizeToFit()
        super.init(frame: .zero)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureContents() {
        addSubview(label)
        label.edgesToSuperview(insets: .init(top: 14, left: 14, bottom: 14, right: 14))
    }
}
