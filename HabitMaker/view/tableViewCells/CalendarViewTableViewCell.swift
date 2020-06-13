//
//  CalendarViewTableViewCell.swift
//  HabitMaker
//
//  Created by Bruno Cardoso Ambrosio on 27/04/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//

import UIKit

/// A table view cell that displays the calendarView that i have made
class CalendarViewTableViewCell: UITableViewCell {
    var calendarView: CalendarView!

    private func commonInit() {
        calendarView = CalendarView()
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(calendarView)
        calendarView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        calendarView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
