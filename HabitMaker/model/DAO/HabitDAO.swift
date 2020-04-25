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
    
    func listAll() -> [Habit] {
        var habits: [Habit] = []
        
        do {
            habits = try context.fetch(Habit.fetchRequest())
        }catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return habits
    }
    
    func genNew() -> Habit {
        return Habit(entity: Habit.entity(), insertInto: context)
    }
    
    func save() {
        CoreDataDAO.shared.saveContext()
    }
    
    func delete(item:Habit) {
        CoreDataDAO.shared.delete(item: item)
    }
    
    init() {}
}
