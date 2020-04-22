//
//  PickerHeaderTableViewCell.swift
//  HabitMaker
//
//  Created by Bruno Cardoso Ambrosio on 21/04/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//

import UIKit

class PickerHeaderTableViewCell: UITableViewCell {
    
    private let iconNames = ["chevron.up","chevron.down"]
    private var selectedIcon = 0
    override var isHidden: Bool {
        didSet{
            textLabel?.isHidden = !oldValue
            accessoryView?.isHidden = !oldValue
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryView = UIImageView(image: UIImage(systemName: iconNames[selectedIcon]))
        textLabel?.tintColor = .label
        
    }
    
    func toggleIcon() {
        accessoryView?.isHidden = false
        selectedIcon = selectedIcon == 1 ? 0 : 1
        accessoryView = UIImageView(image: UIImage(systemName: iconNames[selectedIcon]))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
