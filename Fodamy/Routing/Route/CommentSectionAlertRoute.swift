//
//  CommentSectionAlertRoute.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 7.08.2023.
//

protocol CommentSectionAlertRoute {
    func presentEditDeleteAlert(edit: VoidClosure?, delete: VoidClosure?)
}

extension CommentSectionAlertRoute where Self: RouterProtocol {
    
    func presentEditDeleteAlert(edit: VoidClosure?, delete: VoidClosure?) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let editAction = UIAlertAction(title: L10n.CommentSectionViewModel.alertControllerEditAction, style: .default) {
            [weak self] _ in
            edit?()
        }
        let deleteAction = UIAlertAction(title: L10n.CommentSectionViewModel.alertControllerDeleteAction, style: .destructive) { [weak self] _ in
           delete?()
        }
        let cancelAction = UIAlertAction(title: L10n.CommentSectionViewModel.alertControllerCancelAction, style: .cancel)

        alertController.addAction(editAction)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        
        let transition = ModalTransition()
        
        open(alertController, transition: transition)
    }
}
