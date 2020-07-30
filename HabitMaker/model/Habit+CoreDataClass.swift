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
    
    /// Returns the number of time that this habit was tracked
    var numberOfCompletions: Int{
        get {
            return completions?.count ?? 0
        }
    }
    
    var goalCriterionLiteral: GoalCriterion? {
        GoalCriterion(rawValue: self.goalCriterion ?? "")
    }
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.createdAt = Date()
    }
    
    /// Checks if the completions of this habit has a given date
    /// - Parameter date: date to be found
    /// - Returns: true if date was found, otherwise, false
    func completionsContains(_ date: Date) -> Bool{
        guard let elements = completions else {return false}
        let dates = elements.map { element -> Date in
            return (element as! Completion).date!
        }
        return dates.contains(date)
    }
    
    /// Finds a completion by a given date
    /// - Parameter date: used to search on the list
    /// - Returns: a completion that was on the given Date
    func findCompletion(withDate date: Date) -> Completion? {
        var completionFound: Completion? = nil
        
        completionFound = completions?.first(where:
            { element -> Bool in
                guard let completion = element as? Completion,
                    completion.date == date else {return false}
                return true
        }) as? Completion
        return completionFound
    }
    
    func checkTheCompletionsAchived() {
        if completions == nil || completions!.count == 0 { return }
        let complets = completions?.compactMap{$0 as? Completion} ?? []
        
        complets.forEach { completion in
            completion.setIsAchived()
        }
        calculateStreaks()
    }
    
    /// Calculates the streaks of a habit before save it
    /// - Parameter item: item to be calculated
    func calculateStreaks() {
          var complets = self.completions?.allObjects as! [Completion]
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
          
          self.currStreak = Int64(current)
          self.bestStreak = Int64(longest)
    }
}
