//
//  Habit+CoreDataProperties.swift
//  HabitMaker
//
//  Created by Bruno Cardoso Ambrosio on 04/05/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//
//

import Foundation
import CoreData


extension Habit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Habit> {
        return NSFetchRequest<Habit>(entityName: "Habit")
    }

    @NSManaged public var bestStreak: Int64
    @NSManaged public var createdAt: Date?
    @NSManaged public var currStreak: Int64
    @NSManaged public var title: String?
    @NSManaged public var type: Int16
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
