//
//  UILabel+Extension.swift
//  HabitMaker
//
//  Created by Bruno Cardoso Ambrosio on 17/04/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//

import UIKit

extension UILabel {
    
    /// Applys a font with dynamic type to self
    var dynamicFont: UIFont {
        set {
            self.numberOfLines = 0
            if #available(iOS 10.0, * ){
                self.adjustsFontForContentSizeCategory = true
            }
            let fontMetrics = UIFontMetrics(forTextStyle: .body)
            self.font = fontMetrics.scaledFont(for: newValue)
        }
        get {
            return self.font
        }
    }
}

