//
//  PickerTableViewCell.swift
//  HabitMaker
//
//  Created by Bruno Cardoso Ambrosio on 20/04/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//

import UIKit

class DatePickerTableViewCell: UITableViewCell {
    private(set) var picker: UIDatePicker!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        picker = UIDatePicker()
        
        commonInit()
    }
    
    private func commonInit() {
        picker.date = Date()
        
        addSubview(picker)
        
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        picker.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        picker.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1.0).isActive = true
        picker.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.0).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
