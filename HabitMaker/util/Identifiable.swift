//
//  Identifiable.swift
//  HabitMaker
//
//  Created by Bruno Cardoso Ambrosio on 16/04/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//

import UIKit

protocol Identifiable: class {
    static var defaultReuseIdentifier: String { get }
}

extension Identifiable where Self: UIView {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}
