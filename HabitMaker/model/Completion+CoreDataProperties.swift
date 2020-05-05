//
//  Completion+CoreDataProperties.swift
//  HabitMaker
//
//  Created by Bruno Cardoso Ambrosio on 04/05/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//
//

import Foundation
import CoreData


extension Completion {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Completion> {
        return NSFetchRequest<Completion>(entityName: "Completion")
    }

    @NSManaged public var date: Date?
    @NSManaged public var habit: Habit?

}
