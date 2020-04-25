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
    var imgview = UIImageView(image: UIImage(systemName: "chevron.up"))
    
    
    override var isHidden: Bool {
        didSet{
            textLabel?.isHidden = !oldValue
            imgview.isHidden = !oldValue
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        textLabel?.tintColor = .label
        
        addSubview(imgview)
        
        imgview.translatesAutoresizingMaskIntoConstraints = false
        
        imgview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        imgview.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imgview.heightAnchor.constraint(equalToConstant: 20).isActive = true
        imgview.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        
    }
    
    func toggleIcon() {
        selectedIcon = selectedIcon == 1 ? 0 : 1
        imgview.isHidden = false
        imgview.image = UIImage(systemName: iconNames[selectedIcon])
    }
    func resetIcon() {
        selectedIcon = 0
        imgview.image = UIImage(systemName: iconNames[selectedIcon])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
