//
//  FormFieldTableViewCell.swift
//  HabitMaker
//
//  Created by Bruno Cardoso Ambrosio on 18/04/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//

import UIKit

class FormFieldTableViewCell: UITableViewCell {

    let label: UILabel!
    let value: UITextField!

    let padding: CGFloat = 20.0
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        label = UILabel()
        value = UITextField()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        label = UILabel()
        value = UITextField()
        
        super.init(coder: coder)
        
        commonInit()
    }
    
    func commonInit() {
        selectionStyle = .none
        
        value.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.setContentHuggingPriority(.init(251), for: .horizontal)
        
        addSubview(label)
        addSubview(value)
        
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive = true
        label.trailingAnchor.constraint(equalTo: value.leadingAnchor, constant: -10).isActive = true
        
        value.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding).isActive = true
        value.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        value.textAlignment = .right
        value.clearButtonMode = .whileEditing
    }
    
    /// Toggles its UITextField isEnable
    func toggleFieldEnabled() {
        value.isEnabled = !value.isEnabled
    }
}
