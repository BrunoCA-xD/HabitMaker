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
        
        label.setContentCompressionResistancePriority(.init(1000), for: .horizontal)
        
        let layoutStackView = UIStackView(arrangedSubviews: [label,value])
        layoutStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(layoutStackView)
        layoutStackView.setConstraints(toFill: contentView, horizontalConstant: 20, verticalConstant: 0)
        
        value.textAlignment = .right
        value.isScrollEnabled = false
    }
    
    /// Toggles its UITextView isEditable
    func toggleFieldEditable() {
        value.isEditable = !value.isEditable
    }
}
