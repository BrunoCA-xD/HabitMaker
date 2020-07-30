//
//  HabitDAO.swift
//  HabitMaker
//
//  Created by Bruno Cardoso Ambrosio on 23/04/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//

import Foundation

class HabitDAO {
    
    private let context = CoreDataDAO.shared.persistentContainer.viewContext
    
    /// List all the habits in the database
    /// - Returns: a list with all habits in database
    func listAll() -> [Habit] {
        var habits: [Habit] = []
        
        do {
            habits = try context.fetch(Habit.fetchRequest())
        }catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return habits
    }
    
    /// Generates a new habit using its entity and the context
    /// - Returns: a new habit to be used
    func genNew() -> Habit {
        return Habit(entity: Habit.entity(), insertInto: nil)
    }
    
    /// Calls the generic method to save the database context
    func insert(_ item: Habit) {
        context.insert(item)
        save()
    }
    
    func save() {
        CoreDataDAO.shared.saveContext()
    }
    
    /// Calls the generic method to delete an item
    /// - Parameter item: item to be deleted
    func delete(item: Habit) {
        CoreDataDAO.shared.delete(item: item)
    }
    
    init() {}
}
