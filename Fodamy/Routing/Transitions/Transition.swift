//
//  Transition.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 3.03.2023.
//

import Foundation
import UIKit

protocol Transition: AnyObject {
    var viewController: UIViewController? { get set }

    func open(_ viewController: UIViewController)
    func close(_ viewController: UIViewController)
}
