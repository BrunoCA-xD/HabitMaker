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
    
    private func calculateStreaks(_ item: Habit) {
        var longest = 0 // length of longest subsequence of consecutive dates
        var current = 1 // length of current subsequence of consecutive dates
        
        
        let complets = item.completions?.allObjects as! [Completion]
        
        var arrayDates:[Date] = complets.map { (element) -> Date in
            return element.date!
        }
        arrayDates.sort()
        for (prev, next) in zip(arrayDates, arrayDates.dropFirst()) {
            let nextToPrev = Calendar.current.date(byAdding: DateComponents(day:1), to: prev)
            if next > nextToPrev! {
                // dates are not consecutive, start a new subsequence.
                current = 1
            } else if next == nextToPrev {
                // dates are consecutive, increase current length
                current += 1
            }
            if current > longest {
                longest = current
            }
        }
        item.currStreak = Int64(current)
        if longest > item.bestStreak {
            item.bestStreak = Int64(longest)
        }
    }
    
    func save() {
        CoreDataDAO.shared.saveContext()
    }
    func makeHabitCompleted(item: Habit) {
        calculateStreaks(item)
        save()
    }
    
    func delete(item:Habit) {
        CoreDataDAO.shared.delete(item: item)
    }
    
    init() {}
}
