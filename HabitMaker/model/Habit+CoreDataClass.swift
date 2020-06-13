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
}
