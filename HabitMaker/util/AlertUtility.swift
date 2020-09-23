//
//  AlertUtility.swift
//  HabitMaker
//
//  Created by Bruno Cardoso Ambrosio on 22/04/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//

import Foundation
import UIKit

class AlertUtility {
    
    /// Shows a standard destructive dialog, can be an Alert or an ActionSheet
    /// - Parameters:
    ///   - viewController: the vc where the dialog will be presented
    ///   - title: The title for the dialog
    ///   - message: Something to explain why it has appeared and the effects of the following actions
    ///   - style: of the dialog, can be an actionSheet or Alert
    ///   - cancelAction: handler to be used when user cancels
    ///   - confirmAction: handler to be used when user confirms
    static func destructiveConfirmation(_ viewController: UIViewController,
                                        title: String = AlertTitles.confirmation.localized(),
                                        message: String,
                                        style: UIAlertController.Style,
                                        cancelAction:  ((UIAlertAction) -> Void)? = nil,
                                        confirmAction: ((UIAlertAction) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        let cancelAction = UIAlertAction(title: AlertButtons.cancel.localized(), style: .cancel, handler: cancelAction)
        let confirmAction = UIAlertAction(title: AlertButtons.delete.localized(), style: .destructive, handler: confirmAction)
        alert.addAction(cancelAction)
        alert.addAction(confirmAction)
        viewController.present(alert, animated: true)
    }
}
