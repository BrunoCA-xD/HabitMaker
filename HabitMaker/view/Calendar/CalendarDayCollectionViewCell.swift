//
//  CalendarDayCollectionViewCell.swift
//  HabitMaker
//
//  Created by Bruno Cardoso Ambrosio on 25/04/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//

import UIKit

class CalendarDayCollectionViewCell: UICollectionViewCell, Identifiable {
     
    var date: Date?
    let lbl: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.dynamicFont = UIFont.preferredFont(forTextStyle: .body)
        return l
    }()
    
    func configure(day: Int, components: DateComponents){
        lbl.text = "\(day)"
        date = Calendar.current.date(from: DateComponents(year: components.year, month: components.month,day:day))!
    
        layer.borderWidth = 0
        layer.borderColor = .none
        backgroundColor = .none
        
    }
    
    private func commonInit() {
        addSubview(lbl)
        
        lbl.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lbl.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
