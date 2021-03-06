//
//  Completion+CoreDataProperties.swift
//  HabitMaker
//
//  Created by Bruno Cardoso Ambrosio on 15/06/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//
//

import Foundation
import CoreData


extension Completion {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Completion> {
        return NSFetchRequest<Completion>(entityName: "Completion")
    }

    @NSManaged public var achievedNumber: Double
    @NSManaged public var date: Date?
    @NSManaged public var isAchived: Bool
    @NSManaged public var comment: String?
    @NSManaged public var habit: Habit?

}
