//
//  UIColor+Extensions.swift
//  HabitMaker
//
//  Created by Bruno Cardoso Ambrosio on 26/04/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//

import UIKit

extension UIColor {
    public static var labelOpposite: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                /// Return the color for Dark Mode
                return .black
            } else {
                /// Return the color for Light Mode
                return .white
            }
        }
    }()
}
