//
//  SwitchTableViewCell.swift
//  HabitMaker
//
//  Created by Bruno Cardoso Ambrosio on 18/04/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//

import UIKit

public class SwitchTableViewCell: UITableViewCell {
    
    let label: UILabel!
    let onSwitch: UISwitch!

    let padding: CGFloat = 30.0
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        label = UILabel()
        onSwitch = UISwitch()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        label = UILabel()
        onSwitch = UISwitch()
        
        super.init(coder: coder)
        
        commonInit()
    }
    
    func commonInit() {
        selectionStyle = .none
        
        onSwitch.setOn(false, animated: false)
        onSwitch.isAccessibilityElement = false
        
        imageView?.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        onSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(label)
        addSubview(onSwitch)
        
        self.imageView?.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        self.imageView?.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        self.imageView?.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        if let imageView = self.imageView {
             label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20).isActive = true
        }
        else{
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50).isActive = true
        }
        
       
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        label.trailingAnchor.constraint(equalTo: onSwitch.leadingAnchor, constant: -padding).isActive = true
        
        onSwitch.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        onSwitch.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding).isActive = true
        
    }
}
