//
//  CompletionType.swift
//  HabitMaker
//
//  Created by Bruno Cardoso Ambrosio on 03/05/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//

import Foundation

enum CompletionType: Int16, CaseIterable {
    case yesNo = 0
    case numeric = 1
    
    var description: String  {
        switch self {
        case .yesNo:
            return NSLocalizedString("completionType_yes/no", comment: "")
        case .numeric:
            return NSLocalizedString("completionType_numeric", comment: "")
        }
    }
}
