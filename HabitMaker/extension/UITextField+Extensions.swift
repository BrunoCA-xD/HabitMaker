//
//  UITextField.swift
//  HabitMaker
//
//  Created by Bruno Cardoso Ambrosio on 12/05/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//

import UIKit

extension UITextField {
    func addDoneButtonOnKeyboard(onDone:(target: Any, action: Selector)? = nil){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneParts = onDone != nil ? onDone! : (target: self, action:  #selector(Self.doneButtonAction))
        let done: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: doneParts.target, action: doneParts.action)
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
        
    }
    
    @objc func doneButtonAction(sender: UITextField){
        self.resignFirstResponder()
    }
    
    func resetErrorFormat() {
        self.layer.borderWidth = 0.0
        self.layer.borderColor = UIColor.clear.cgColor
    }
    
    func applyErrorFormat() {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.systemRed.cgColor
    }
}
