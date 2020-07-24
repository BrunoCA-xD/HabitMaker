//
//  HabitTableViewCell.swift
//  HabitMaker
//
//  Created by Bruno Cardoso Ambrosio on 16/04/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//

import UIKit

class HabitTableViewCell: UITableViewCell,Identifiable {
    
    var myViewHeightConstraint: NSLayoutConstraint!
    
    //MARK: Outlets
    let titleLabel: UILabel = {
        let label = UILabel()
        label.dynamicFont = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.textColor =  UIColor.label
        return label
    }()
    let streakLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Streak: 0"
        label.dynamicFont = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.caption1)


        label.adjustsFontForContentSizeCategory = true
        label.textColor =  UIColor.label
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .secondarySystemBackground

        addSubview(titleLabel)
        addSubview(streakLabel)
        
        clipsToBounds = true
        let heightConstraint = heightAnchor.constraint(greaterThanOrEqualToConstant: 71)
            
        heightConstraint.priority = .init(UILayoutPriority .defaultHigh.rawValue-1)
        
        heightConstraint.isActive = true
        
        
        titleLabel.topAnchor.constraint(equalTo: titleLabel.superview!.topAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: titleLabel.superview!.trailingAnchor, constant: -10).isActive = true
        
        streakLabel.topAnchor.constraint(lessThanOrEqualTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        streakLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        streakLabel.bottomAnchor.constraint(equalTo: streakLabel.superview!.bottomAnchor, constant: -10).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
