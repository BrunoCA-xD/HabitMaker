//
//  Date+Extensions.swift
//  HabitMaker
//
//  Created by Bruno Cardoso Ambrosio on 16/04/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//

import Foundation

extension Date {
    
    private var calendar: Calendar {
        return Calendar.current
    }
    
    private static var calendar: Calendar {
        return Calendar.current
    }
    
    var isToday: Bool {
        return calendar.isDateInToday(self)
    }
    
    var isYesterday: Bool {
        return calendar.isDateInYesterday(self)
    }
    
    /// Discovers when is the next date by adding 1 day to self
    /// - Returns: a Date representing self adding 1 day
    func nextDate() -> Date? {
        return Calendar.current.date(byAdding: DateComponents(day:1), to: self)
    }
    
    /// Returns only the date part of a Date converted to String
    var dateValue: String {
        return DateFormatter.localizedString(from: self, dateStyle: .medium, timeStyle: .none)
    }
    
    /// Returns only the time part of a Date converted to String
    var timeValue: String {
        return DateFormatter.localizedString(from: self, dateStyle: .none, timeStyle: .short)
    }
    
    /// Discovers when is the start of a month in a date
    /// - Returns: a date with the first day of a given month (in date)
    static func startOfMonth(date: Date) -> Date {
        return calendar.date(from: calendar.dateComponents([.year, .month], from: calendar.startOfDay(for: date)))!
    }
    
    /// Discovers when is the end of a month in a date
    /// - Returns: a date with the last day of a given month (in date)
    static func endOfMonth(date: Date) -> Date {
        return calendar.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth(date: date))!
    }
    
    /// Return the number of days by month given an year
    /// - Parameter year: In which year the function will get the amount of days
    /// - Returns: An array representing the number of days by month in the year
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
