//
//  HeaderView.swift
//  HabitMaker
//
//  Created by Bruno Cardoso Ambrosio on 18/04/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//

import UIKit

class ModalHeaderView: UIView {

    let headerTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.dynamicFont = UIFont.preferredFont(forTextStyle: .title1)
        return label
    }()
    
    let closeButton: UIButton = {
        let b = UIButton(type: .close)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    var confirmButton: UIButton? = nil
    
    init(needsConfirmButton:Bool) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(headerTitle)
        self.addSubview(closeButton)
        

        
        headerTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        headerTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        closeButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        closeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        
        if needsConfirmButton {
            confirmButton = genConfirmButton()
            
            self.addSubview(confirmButton!)
            
            confirmButton!.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            confirmButton!.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func genConfirmButton() -> UIButton {
        let b = UIButton(type: .system)
        b.setTitle("Save", for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.tintColor = .systemBlue
        return b
    }

}
