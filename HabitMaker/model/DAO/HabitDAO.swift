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
        return Habit(entity: Habit.entity(), insertInto: context)
    }
    
    /// Calculates the streaks of a habit before save it
    /// - Parameter item: item to be calculated and then saved
    func calculateStreaks(_ item: Habit) {
        var complets = item.completions?.allObjects as! [Completion]
        var longest = 0
        var current = 0
        
        complets.sort { return $0.date! < $1.date! }
        let filteredList = complets.filter{ return $0.isAchived }
        let consecutiveList = filteredList.splitConsecutive()
        if !consecutiveList.isEmpty {
            for list in consecutiveList {
                if list.count > longest {
                    longest = list.count
                }
            }
            current = consecutiveList.last!.count
        }
        
        item.currStreak = Int64(current)
        item.bestStreak = Int64(longest)

        save()
        
    }
    
    /// Calls the generic method to save the database context
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
