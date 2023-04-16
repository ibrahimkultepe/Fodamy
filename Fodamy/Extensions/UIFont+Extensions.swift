//
//  UIFont+Extensions.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 14.04.2023.
//

import Foundation
import UIKit

extension UIFont {
    
    static func nunitoBold(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Nunito-Bold", size: size) else {
            fatalError("Unable to initialize font")
        }
        return font
    }
    
    static func nunitoExtraBold(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Nunito-ExtraBold", size: size) else {
            fatalError("Unable to initialize font")
        }
        return font
    }
    
    static func nunitoSemiBold(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Nunito-SemiBold", size: size) else {
            fatalError("Unable to initialize font")
        }
        return font
    }
}
