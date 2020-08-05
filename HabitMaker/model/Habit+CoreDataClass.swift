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
    
    /// Returns the completions as a Completion collection in descending order
    private var completionsSorted: [Completion] {
        (self.completions?.allObjects as? [Completion] ?? []).sorted { return $0.date! < $1.date! }
    }
    
    /// Returns total of data tracked
    var numberOfCompletions: Int{
        completions?.count ?? 0
    }
    /// Calculates longest achived streak
    var longestStreak: Int{
        completionsSorted
            .filter{ $0.isAchived }
            .splitConsecutive()
            .max{ $0.count-1 < $1.count-1 }?.count ?? 0
    }
    /// Calculates current achived streak
    var currentStreak: Int{
        completionsSorted
            .filter{ $0.isAchived }
            .splitConsecutive().last?.count ?? 0
    }
    
    //Enum property accessors/writers
    var completionType: CompletionType {
        get {
            willAccessValue(forKey: "completionType")
            defer { didAccessValue(forKey: "completionType") }
            return CompletionType(rawValue: typePrimitive)!
        }
        set {
            willChangeValue(forKey: "completionType")
            defer { didChangeValue(forKey: "completionType") }
            typePrimitive = newValue.rawValue
        }
    }
    
    var goalCriterion: GoalCriterion? {
        get {
            willAccessValue(forKey: "goalCriterion")
            defer { didAccessValue(forKey: "goalCriterion") }
            return GoalCriterion(rawValue: goalCriterionPrimitive ?? "")
        }
        set {
            willChangeValue(forKey: "goalCriterion")
            defer { didChangeValue(forKey: "goalCriterion") }
            goalCriterionPrimitive = newValue?.rawValue
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
        let dates = completionsSorted.map { element -> Date in
            return element.date!
        }
        return dates.contains(date)
    }
    
    /// Finds a completion by a given date
    /// - Parameter date: used to search on the list
    /// - Returns: a completion that was on the given Date
    func findCompletion(withDate date: Date) -> Completion? {
        var completionFound: Completion? = nil
        completionFound = completionsSorted.first(where: { element -> Bool in
            element.date == date
        })
        /*        completionFound = completions?.first(where:
        //            { element -> Bool in
        //                guard let completion = element as? Completion,
        //                    completion.date == date else {return false}
        //                return true
                }) as? Completion */
        return completionFound
    }
    
    func checkTheCompletionsAchived() {
        if completionsSorted.count == 0 {return}
        completionsSorted.forEach { completion in
            completion.setIsAchived()
        }
    }
}
