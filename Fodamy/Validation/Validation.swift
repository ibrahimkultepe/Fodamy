//
//  Validation.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 13.06.2023.
//

class Validation {
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        
        guard emailPred.evaluate(with: email) else {
            ToastPresenter.showWarningToast(text: L10n.Validation.isValidEmail)
            return false
        }
        return true
    }
    
    func isValidPassword(_ password: String) -> Bool {
        guard password.count > 5 else {
            ToastPresenter.showWarningToast(text: L10n.Validation.isValidPassword)
            return false
        }
        return true
    }
    
    func isValidName(_ name: String) -> Bool {
        guard name.count > 1 else {
            ToastPresenter.showWarningToast(text: L10n.Validation.isValidName)
            return false
        }
        return true
    }
}
