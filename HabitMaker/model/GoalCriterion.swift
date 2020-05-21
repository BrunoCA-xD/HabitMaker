//
//  GoalCriterion.swift
//  HabitMaker
//
//  Created by Bruno Cardoso Ambrosio on 17/05/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//

import Foundation

enum GoalCriterion: String, CaseIterable{
    case lessThanOrEqual
    case exactly
    case greaterThanOrEqual
    
    var showValue: String  {
        switch self {
        case .lessThanOrEqual:
            return "No more than"
        case .exactly:
            return "Exactly"
        case .greaterThanOrEqual:
            return "At least"
        }
    }
}
