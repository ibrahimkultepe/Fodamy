//
//  ReusableView+Extensions.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 14.04.2023.
//

import UIKit

public extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}
