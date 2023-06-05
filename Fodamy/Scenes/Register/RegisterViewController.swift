//
//  RegisterViewController.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 5.06.2023.
//

import UIKit

final class RegisterViewController: BaseViewController<RegisterViewModel> {
    
    private let titleLabel = UILabelBuilder()
        .font(.font(.nunitoBold, size: .xxLarge))
        .build()
    
    private let stackView = UIStackViewBuilder()
        .axis(.vertical)
        .spacing(20)
        .build()
    
    private let userName = UITextField()
    private let email = UITextField()
    private let password = UITextField()
    
    private let signUpButton = UIButtonBuilder()
        .backgroundColor(.appHeather)
        .titleColor(.appSecondaryBackground)
        .titleFont(.font(.nunitoBold, size: .xxLarge))
        .build()
    
    private let bottomStackView = UIStackViewBuilder()
        .spacing(10)
        .axis(.horizontal)
        .build()
    
    private let bottomLabel = UILabelBuilder()
        .font(.font(.nunitoSemiBold, size: .large))
        .textColor(.appRaven)
        .build()
    
    private let loginButton = UIButtonBuilder()
        .titleColor(.appRed)
        .titleFont(.font(.nunitoSemiBold, size: .large))
        .build()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
