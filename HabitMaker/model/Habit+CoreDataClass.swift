//
//  Habit+CoreDataClass.swift
//  HabitMaker
//
//  Created by Bruno Cardoso Ambrosio on 23/04/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//
//

import Foundation
import CoreData


public class Habit: NSManagedObject {

    public override func awakeFromInsert() {
        self.createdAt = Date()
        self.completions = NSSet(array: [])
    }
}
