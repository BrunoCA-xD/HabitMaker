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
    static func validationAlertWithTitle(title: String!, message: String, ViewController: UIViewController, input: UIControl?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler:{ action in
            self.action(input)
        })
        alert.addAction(action)
        ViewController.present(alert, animated: true, completion: nil)
    }
    
    static func action(_ input: UIControl?) {
        input?.shake()
        input?.becomeFirstResponder()
        input?.layer.borderWidth = 1.0
        input?.layer.borderColor = UIColor.red.cgColor
        
    }
}
