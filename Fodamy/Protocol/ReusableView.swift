//
//  ReusableView.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 14.04.2023.
//

import UIKit

public protocol ReusableView: AnyObject {
    static var defaultReuseIdentifier: String { get }
}
