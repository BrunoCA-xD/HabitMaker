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
        
        label.setContentHuggingPriority(.init(251), for: .horizontal)
        
        let layoutStackView = UIStackView(arrangedSubviews: [label,value])
        layoutStackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(layoutStackView)
        
        layoutStackView.setConstraints(toFill: contentView, horizontalConstant: 20, verticalConstant: 0)
        layoutStackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 44).isActive = true
        
        value.textAlignment = .right
        value.clearButtonMode = .whileEditing
        
    }
    
    /// Toggles its UITextField isEnable
    func toggleFieldEnabled() {
        value.isEnabled = !value.isEnabled
    }
}
