//
//  Habit+CoreDataProperties.swift
//  HabitMaker
//
//  Created by Bruno Cardoso Ambrosio on 29/05/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//
//

import Foundation
import CoreData


extension Habit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Habit> {
        return NSFetchRequest<Habit>(entityName: "Habit")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var goalAction: String?
    @NSManaged public var goalCriterionPrimitive: String?
    @NSManaged public var goalNumber: Double
    @NSManaged public var goalUnit: String?
    @NSManaged public var title: String?
    @NSManaged public var typePrimitive: Int16
    @NSManaged public var completions: NSSet?

}

// MARK: Generated accessors for completions
extension Habit {

    @objc(addCompletionsObject:)
    @NSManaged public func addToCompletions(_ value: Completion)

    @objc(removeCompletionsObject:)
    @NSManaged public func removeFromCompletions(_ value: Completion)

    @objc(addCompletions:)
    @NSManaged public func addToCompletions(_ values: NSSet)

    @objc(removeCompletions:)
    @NSManaged public func removeFromCompletions(_ values: NSSet)

}
