//
//  ReusableView.swift
//  UIComponents
//
//  Created by İbrahim Kültepe on 17.04.2023.
//

import UIKit

public protocol ReusableView: AnyObject {
    static var defaultReuseIdentifier: String { get }
}
