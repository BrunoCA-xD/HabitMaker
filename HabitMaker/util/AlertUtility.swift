//
//  AlertUtility.swift
//  HabitMaker
//
//  Created by Bruno Cardoso Ambrosio on 22/04/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//

import Foundation
import UIKit
//TODO: I'm not using this utility class anymore
class AlertUtility {
    
    /// Shows a standard information alert 
    /// - Parameters:
    ///   - title: alert title
    ///   - message: alert message
    ///   - viewController: who'll present the alert
    static func alertWithTitle(title: String!, message: String, viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        viewController.present(alert, animated: true, completion: nil)
    }
}
