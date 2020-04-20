//
//  Date+Extensions.swift
//  HabitMaker
//
//  Created by Bruno Cardoso Ambrosio on 16/04/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//

import Foundation

extension Date {
    var stringValue: String {
        return DateFormatter.localizedString(from: self, dateStyle: .medium, timeStyle: .none)
    }
    
    var isToday: Bool {
        let calendar = Calendar.current
        return calendar.isDateInToday(self)
    }
    
    var isYesterday: Bool {
        let calendar = Calendar.current
        return calendar.isDateInYesterday(self)
    }
}
