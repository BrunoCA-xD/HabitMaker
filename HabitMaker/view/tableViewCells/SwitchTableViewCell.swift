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
    private let imgView: UIImageView!
    var icon: UIImage! = nil {
        didSet {
            imgView.image = icon
            updateConstraints()
        }
    }
    
    private let padding: CGFloat = 30.0
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        label = UILabel()
        onSwitch = UISwitch()
        imgView = UIImageView()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        label = UILabel()
        onSwitch = UISwitch()
        imgView = UIImageView()
        
        super.init(coder: coder)
        
        commonInit()
    }
    
    fileprivate func setConstraints() {
        imgView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        onSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        imgView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        imgView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        imgView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imgView.setContentHuggingPriority(.init(251), for: .horizontal)
        
        label.setContentHuggingPriority(.init(251), for: .horizontal)
        label.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: 10).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: onSwitch.leadingAnchor, constant: -padding).isActive = true
        
        onSwitch.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        onSwitch.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding).isActive = true
    }
    
    func commonInit() {
        selectionStyle = .none
        
        onSwitch.setOn(false, animated: false)
        onSwitch.isAccessibilityElement = false
        
        addSubview(imgView)
        addSubview(label)
        addSubview(onSwitch)
        
        setConstraints()
        
    }
    
}
