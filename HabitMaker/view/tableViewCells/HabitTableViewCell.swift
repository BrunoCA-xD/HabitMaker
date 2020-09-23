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
        label.adjustsFontForContentSizeCategory = true
        label.textColor = UIColor.label
        return label
    }()
    let streakLabel: UILabel = {
        let label = UILabel()
        label.dynamicFont = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.subheadline)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = UIColor.secondaryLabel
        return label
    }()
    
    fileprivate func commonInit() {
        self.backgroundColor = .secondarySystemBackground
        let layoutStackView = UIStackView(arrangedSubviews: [titleLabel,streakLabel])
        layoutStackView.translatesAutoresizingMaskIntoConstraints = false
        layoutStackView.axis = .vertical
        layoutStackView.alignment = .leading
        layoutStackView.distribution = .fillEqually
        
        //cell height constraint
        let heightConstraint = contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 71)
        heightConstraint.priority = .init(UILayoutPriority .defaultHigh.rawValue-1)
        heightConstraint.isActive = true
        
        contentView.addSubview(layoutStackView)
        
        //layoutStackView constraints
        layoutStackView.setConstraints(toFill: contentView, horizontalConstant: 20)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        commonInit()
        
    }
    
    func config(with habit: Habit) {
        titleLabel.text = habit.title?.capitalized
        streakLabel.text = "\(HabitsTableViewCellStrings.streakLabel.localized()): \(habit.currentStreak)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
