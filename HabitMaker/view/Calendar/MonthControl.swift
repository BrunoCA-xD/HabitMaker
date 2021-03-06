//
//  MonthControl.swift
//  HabitMaker
//
//  Created by Bruno Cardoso Ambrosio on 25/04/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//

import UIKit

protocol MonthControlActions {
    func previousMonthTapped()
    func nextMonthTapped()
}

class MonthControl: UIView {
    //MARK: - outltes
    let previousMonth: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        let icon = UIImage(systemName: "chevron.left")!.withTintColor(.link)
        b.setImage(UIImage.resizeImage(image: icon, targetSize: CGSize(width: 25, height: 25)), for: .normal)
        return b
    }()
    private let monthSymbol: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.dynamicFont = UIFont.preferredFont(forTextStyle: .title3)
        return l
    }()
    let nextMonth: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        let icon = UIImage(systemName: "chevron.right")!.withTintColor(.link)
        b.setImage(UIImage.resizeImage(image: icon, targetSize: CGSize(width: 25, height: 25)), for: .normal)
        return b
    }()
    var delegate: MonthControlActions?
    
    let monthSymbols = Calendar.current.monthSymbols
    
    /// Updates the viweing month details
    /// - Parameters:
    ///   - index: the index of the month ex: January = 1, february = 2
    ///   - year: the year that will be shown on the calendar
    func updateMonthSymbol(monthIndex index:Int, year: Int){
        monthSymbol.text = "\(monthSymbols[index-1]), \(year)"
    }
    
    private func commonInit() {
        clipsToBounds = true
        
        addSubview(previousMonth)
        addSubview(monthSymbol)
        addSubview(nextMonth)
        
        heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        //previousMonth constraints
        previousMonth.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        previousMonth.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        previousMonth.heightAnchor.constraint(equalToConstant: 44).isActive = true
        previousMonth.widthAnchor.constraint(equalToConstant: 44).isActive = true
        
        //monthSymbol constraints
        monthSymbol.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        monthSymbol.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        //nextMonth constraints
        nextMonth.heightAnchor.constraint(equalToConstant: 44).isActive = true
        nextMonth.widthAnchor.constraint(equalToConstant: 44).isActive = true
        nextMonth.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        nextMonth.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            
        previousMonth.addTarget(self, action: #selector(Self.previousMonthTapped), for: .touchUpInside)
        nextMonth.addTarget(self, action: #selector(Self.nextMonthTapped), for: .touchUpInside)
    }
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 200, height: 44))
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    /// Changes the viewing month to the previous of the current
    @objc func previousMonthTapped() {
        delegate?.previousMonthTapped()
    }
    /// Changes the viewing month to the next of the current
    @objc func nextMonthTapped() {
        delegate?.nextMonthTapped()
    }
}
