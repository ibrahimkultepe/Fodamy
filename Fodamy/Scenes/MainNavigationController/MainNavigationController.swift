//
//  MainNavigationController.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 4.05.2023.
//

class MainNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureContents()
    }
    
    private func configureContents() {
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.appWhite,
                                   NSAttributedString.Key.font: UIFont.font(.nunitoBold, size: .xxLarge)]

        navigationBar.titleTextAttributes = titleTextAttributes
        navigationBar.tintColor = UIColor.appWhite
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = .appRed
            appearance.titleTextAttributes = titleTextAttributes
            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance
            navigationBar.compactAppearance = appearance
            navigationBar.tintColor = UIColor.appWhite
        } else {
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = .appRed
            navigationBar.backgroundColor = .appRed
        }
    }
}
