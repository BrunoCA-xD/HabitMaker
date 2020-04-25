//
//  Habit.swift
//  HabitMaker
//
//  Created by Bruno Cardoso Ambrosio on 16/04/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//

import Foundation

struct Habit1: Codable{
    var title: String!
    let dateCreated: Date = Date()
    
    var currStreak: Int = 0
    var bestStreak: Int = 0
    var lastCompletionDate: [Date] = []
    var numberOfCompletions: Int = 0
    
    var hasCompletedForToday: Bool{
        return (lastCompletionDate.contains(Date()))
    }
    
    init(){}
    
    init(title: String) {
        self.title = title
    }
    
}
