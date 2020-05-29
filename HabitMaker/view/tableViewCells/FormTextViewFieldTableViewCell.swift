//
//  FormTextViewFieldTableViewCell.swift
//  HabitMaker
//
//  Created by Bruno Cardoso Ambrosio on 27/05/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//

import UIKit

class FormTextViewFieldTableViewCell: UITableViewCell {
    let label: UILabel!
    let value: UITextView!
    
    let padding: CGFloat = 20.0
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        label = UILabel()
        value = UITextView()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        label = UILabel()
        value = UITextView()
        
        super.init(coder: coder)
        
        commonInit()
    }
    
    func commonInit() {
        selectionStyle = .none
        value.font = label.font
        
        value.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.setContentHuggingPriority(.init(251), for: .horizontal)
        
        addSubview(label)
        addSubview(value)
        
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive = true
        label.trailingAnchor.constraint(equalTo: value.leadingAnchor, constant: -10).isActive = true
        
        value.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding).isActive = true
        value.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        value.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        
        value.textAlignment = .right
        value.isScrollEnabled = false
    }
    
    func toggleFieldEditable() {
        value.isEditable = !value.isEditable
    }
}
