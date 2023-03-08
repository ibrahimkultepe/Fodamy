//
//  Animator.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 3.03.2023.
//

import UIKit

protocol Animator: UIViewControllerAnimatedTransitioning {
    var isPresenting: Bool { get set }
}
