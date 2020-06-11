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
    
    fileprivate func resetStreaks(_ item: Habit) {
        item.currStreak = 0
        item.bestStreak = 0
    }
    
    func calculateStreaks(_ item: Habit) {
        var complets = item.completions?.allObjects as! [Completion]
        var current = 0
        var longest = 0
        
        resetStreaks(item)
        
        complets.sort { return $0.date! < $1.date!}
        
        if complets.count > 0 {
            if complets.last?.isAchived == true {
                current = 1
                longest = 1
            }else {
                if complets.count == 2 && complets[0].isAchived {
                    longest = 1
                    print("acertou miseravi")
                }
            }
        }else {
            resetStreaks(item)
        }
        for (previous, next) in zip(complets, complets.dropFirst()) {
            if (next.date == previous.date?.nextDate()) == true {
                //consecutive
                if previous.isAchived {
                    current+=1
                }else{
                    current = 1

                }
            }else {
                current = 1
            }
            if current > longest {
                longest = current
            }
        }
        
        if complets.last?.isAchived == false {
            current = 0
            
        }
        item.currStreak = Int64(current)
        item.bestStreak = Int64(longest)

        save()
        /*
         if complets.count == 0 {
                    return resetStreaks(item)
                }else {
                    if complets.last?.isAchived == true {
                        current = 1
                        longest = 1
                    }else {
                        current = 0
                    }
                    if item.bestStreak > complets.count {
                        item.bestStreak = 0
                    }
                }

                
                for (p,n) in zip(complets,complets.dropFirst()) {
                    
                    if n.date! > p.date!.nextDate()! {
                        //dates not consecutive, re start streak count
                        current = 1
                    } else if n.date! == p.date!.nextDate()! {
                        //dates are consecutive
                        current+=1
                    }
                    if current > longest {
                        longest = current
                    }
                }
                
                
                item.currStreak = Int64(current)
                if longest > item.bestStreak {
                    item.bestStreak = Int64(longest)
                }
         
         */
    }
    
    func save() {
        CoreDataDAO.shared.saveContext()
    }
    
    func delete(item: Habit) {
        CoreDataDAO.shared.delete(item: item)
    }
    
    init() {}
}
