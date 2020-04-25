//
//  WeekDaysView.swift
//  HabitMaker
//
//  Created by Bruno Cardoso Ambrosio on 25/04/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//

import UIKit

class WeekDaysStackView: UIStackView {
    
    
    init(){
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        setupView()
    }
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView(){
        self.distribution = .fillEqually
        
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale.current
        
        let daysArr = calendar.shortWeekdaySymbols
        for i in 0..<7 {
            let lbl = UILabel()
            lbl.text = daysArr[i].uppercased()
            lbl.textAlignment = .center
            self.addArrangedSubview(lbl)
           
        }
    }
    
}
