//
//  ToastPresenter.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 26.02.2023.
//

import SwiftEntryKit

class ToastPresenter {
    
    static func showWarningToast(text: String) {
        var attributes = EKAttributes.topToast
        attributes.entryBackground = .color(color: EKColor(light: .red, dark: .red))
        attributes.entranceAnimation = .translation
        attributes.exitAnimation = .translation
        
        let customView = TostWarningView(text: text)
        SwiftEntryKit.display(entry: customView, using: attributes)
    }
}
