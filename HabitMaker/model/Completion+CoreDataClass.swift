//
//  Completion+CoreDataClass.swift
//  HabitMaker
//
//  Created by Bruno Cardoso Ambrosio on 02/05/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Completion)
public class Completion: NSManagedObject {

    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.achievedNumber = 0.0
        self.isAchived = false
    }
    
    /// Checks if this completions is the consecutive of another by looking on its dates
    /// - Parameter completion: Another completion to be check if its the next
    /// - Returns: true if this date is right after the given completion date
    func isConsecutive(of completion: Completion) -> Bool {
        if (self.date == completion.date?.nextDate()) == true {
            return true
        }
        return false
    }
    
    func setIsAchived() {
        let goalNumber = habit?.goalNumber ?? 0.0
        let goalCriterion = habit?.goalCriterionLiteral
        var isAchieved = false
        switch goalCriterion {
        case .lessThanOrEqual:
            isAchieved = achievedNumber <= goalNumber
            break
        case .greaterThanOrEqual:
            isAchieved = achievedNumber >= goalNumber
            break
        default:
            isAchieved =  achievedNumber == goalNumber
        }
        isAchived = isAchieved
    }
}
