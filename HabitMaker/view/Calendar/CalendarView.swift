//
//  Calendar.swift
//  HabitMaker
//
//  Created by Bruno Cardoso Ambrosio on 26/04/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//

import UIKit


class CalendarView: UIStackView {
    
    var monthControl: MonthControl!
    var weekdaysView: WeekDaysStackView!
    var daysCollection: DaysCollectionView?
    
    var showingMonthIndex = 0 {
        didSet {
            daysCollection?.numOfDaysByMonth = Date.numOfDaysByMonth(inYear: showingYear)
        }
    }
    var showingYear = 0
    
    fileprivate func initializeAttributes() {
        showingMonthIndex = Calendar.current.component(.month, from: Date())
        showingYear = Calendar.current.component(.year, from: Date())
        
        monthControl.updateMonthSymbol(monthIndex: showingMonthIndex, year: showingYear)
        daysCollection?.refreshData()
        
    }
    
    private func commonInit() {
        spacing = 5
        distribution = .fill
        alignment = .fill
        translatesAutoresizingMaskIntoConstraints = false
        axis = .vertical

        monthControl = MonthControl()
        monthControl.delegate = self
        weekdaysView = WeekDaysStackView()

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 10
        flowLayout.itemSize = CGSize(width: 44, height: 44)

        daysCollection = DaysCollectionView(collectionViewLayout: flowLayout)
        daysCollection?.calendarView = self
        daysCollection?.setContentCompressionResistancePriority(.required, for: .vertical)

        addArrangedSubview(monthControl)
        addArrangedSubview(weekdaysView)
        if daysCollection != nil {
            addArrangedSubview(daysCollection!)
        }
        
        initializeAttributes()

    }
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        commonInit()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
}

extension CalendarView: MonthControlActions {
    func previousMonthTapped() {
        showingMonthIndex -= 1
        if showingMonthIndex < 0 {
            showingMonthIndex = 11
            showingYear -= 1
        }
        monthControl.updateMonthSymbol(monthIndex: showingMonthIndex, year: showingYear)
        daysCollection?.refreshData()
        
    }
    
    func nextMonthTapped() {
        showingMonthIndex += 1
        if(showingMonthIndex > 11){
            showingMonthIndex = 0
            showingYear += 1
        }
       monthControl.updateMonthSymbol(monthIndex: showingMonthIndex, year: showingYear)
        daysCollection?.refreshData()
    }
    
    
}
