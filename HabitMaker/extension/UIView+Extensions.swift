//
//  UIView+Extensions.swift
//  HabitMaker
//
//  Created by Bruno Cardoso Ambrosio on 22/04/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//

import UIKit

extension UIView {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.8
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0]
        layer.add(animation, forKey: "shake")
        UIDevice.vibrate()
    }
    
    func setConstraints(toFill parent: UIView, horizontalConstant: CGFloat = 0, verticalConstant: CGFloat = 0) {
        self.topAnchor.constraint(equalTo: parent.topAnchor,  constant: verticalConstant).isActive = true
        self.bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: -verticalConstant).isActive = true
        self.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: horizontalConstant).isActive = true
        self.trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: -horizontalConstant).isActive = true
    }
}
