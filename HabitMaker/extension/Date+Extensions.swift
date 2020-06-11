//
//  Date+Extensions.swift
//  HabitMaker
//
//  Created by Bruno Cardoso Ambrosio on 16/04/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//

import Foundation

extension Date {
    func nextDate() -> Date? {
        return Calendar.current.date(byAdding: DateComponents(day:1), to: self)
    }
    
    private var calendar: Calendar {
        return Calendar.current
    }
    
    private static var calendar: Calendar {
        return Calendar.current
    }
    
    var dateValue: String {
        return DateFormatter.localizedString(from: self, dateStyle: .medium, timeStyle: .none)
    }
    var timeValue: String {
        return DateFormatter.localizedString(from: self, dateStyle: .none, timeStyle: .short)
    }
    
    var isToday: Bool {
        return calendar.isDateInToday(self)
    }
    
    var isYesterday: Bool {
        return calendar.isDateInYesterday(self)
    }
    
   static func startOfMonth(date: Date) -> Date {
        return calendar.date(from: calendar.dateComponents([.year, .month], from: calendar.startOfDay(for: date)))!
    }
    
   static func endOfMonth(date: Date) -> Date {
        return calendar.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth(date: date))!
    }
    
    static func numOfDaysByMonth(inYear year:Int?) -> [Int] {
        var numOfDaysByMonth: [Int] = []
        let monthCount = calendar.monthSymbols.count
        
        for i in 1...monthCount {
           let year = year != nil ? year : calendar.component(.year, from: Date())
            let dateComponents = DateComponents(year: year, month: i)
            let date = calendar.date(from: dateComponents)!
            
            let range = calendar.range(of: .day, in: .month, for: date)!
            let numDays = range.count
            numOfDaysByMonth.append(numDays)
        }
        return numOfDaysByMonth
    }
}
