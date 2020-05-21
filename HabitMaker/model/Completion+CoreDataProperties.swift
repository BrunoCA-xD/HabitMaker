//
//  Completion+CoreDataProperties.swift
//  HabitMaker
//
//  Created by Bruno Cardoso Ambrosio on 21/05/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//
//

import Foundation
import CoreData


extension Completion {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Completion> {
        return NSFetchRequest<Completion>(entityName: "Completion")
    }

    @NSManaged public var achievedNumber: Int64
    @NSManaged public var date: Date?
    @NSManaged public var isAchived: Bool
    @NSManaged public var habit: Habit?

}
