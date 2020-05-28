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
    
    var numberOfCompletions: Int{
        get {
            return completions?.count ?? 0
        }
    }
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.createdAt = Date()
    }
    func completionsContains(_ date: Date) -> Bool{
        guard let elements = completions else {return false}
        let dates = elements.map { element -> Date in
            return (element as! Completion).date!
        }
        return dates.contains(date)
    }
    
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
