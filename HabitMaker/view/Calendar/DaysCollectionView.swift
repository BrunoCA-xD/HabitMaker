//
//  CalendarView.swift
//  HabitMaker
//
//  Created by Bruno Cardoso Ambrosio on 25/04/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//

import UIKit

protocol DayCellActionsDelegate: class {
    func dayCellTapped(date: Date)
}

protocol DaysCollectionViewFormattingDelegate: class {
    func shouldApplyCustomFormatting(_ date: Date?) -> Bool
    func applyCustomFormat(_ cell: CalendarDayCollectionViewCell)
}

/// Represents the days collection in a month
class DaysCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    //The view that its collection will be inside
    weak var calendarView: CalendarView!
    
    var numOfDaysByMonth = Date.numOfDaysByMonth(inYear: nil)
    var presentMonthIndex = 0
    var presentYear = 0
    var todaysDate = 0
    var firstWeekdayOfMonth = 0 //(Sunday-Saturday 1-7)
    
    weak var formattingDelegate: DaysCollectionViewFormattingDelegate?

    func setupView(){
        self.backgroundColor = .clear
        self.isScrollEnabled = false
        clipsToBounds = true
        
        delegate = self
        dataSource = self
        self.register(CalendarDayCollectionViewCell.self, forCellWithReuseIdentifier: CalendarDayCollectionViewCell.defaultReuseIdentifier)
        
    }
    
    func refreshData(){
        
        todaysDate = Calendar.current.component(.day, from: Date())
        firstWeekdayOfMonth = getFirstWeekday()
        
        presentMonthIndex = Calendar.current.component(.month, from: Date())-1
        
        presentYear = Calendar.current.component(.year, from: Date())
        
        reloadData()
    }
    
    func getFirstWeekday() -> Int{
        let monthDate = Calendar.current.date(from: DateComponents(year: calendarView.showingYear, month: calendarView.showingMonthIndex,day:1))!
        
        let day = Calendar.current.component(.weekday, from: monthDate )
        
        return day == 7 ? 1 : day
    }
    
    //MARK: - Cell format methods
    fileprivate func formatTodaysCell(_ cell: CalendarDayCollectionViewCell) {
        cell.backgroundColor = UIColor.systemBlue
        cell.lbl.textColor =  UIColor.white
        cell.layer.cornerRadius = 15.0
    }
    
    fileprivate func formatNormalCells(_ cell: CalendarDayCollectionViewCell) {
        cell.lbl.textColor = UIColor.label
    }
    
    //MARK: - CollectionView Delegate & DataSource
    fileprivate func itemsDayIsToday(_ item: CalendarDayCollectionViewCell) -> Bool {
        guard let itemsDate = item.date else {return false}
        let rightDate = Calendar.current.date(byAdding: .month, value: 1, to: itemsDate)
        return rightDate?.isToday == true
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarDayCollectionViewCell.defaultReuseIdentifier,for: indexPath) as! CalendarDayCollectionViewCell
        if indexPath.item <= firstWeekdayOfMonth-2 {
            cell.isHidden = true
        }else {
            let calcDate = indexPath.row-firstWeekdayOfMonth+2
            cell.isHidden = false
            cell.configure(day: calcDate, components:  DateComponents(year: calendarView.showingYear, month: calendarView.showingMonthIndex))
            if itemsDayIsToday(cell) {
                formatTodaysCell(cell)
            }else {
                formatNormalCells(cell)
            }
            if formattingDelegate?.shouldApplyCustomFormatting(cell.date) == true {
                formattingDelegate?.applyCustomFormat(cell)
            }else {
                formatNormalCells(cell)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dayCell = collectionView.cellForItem(at: indexPath) as! CalendarDayCollectionViewCell
        calendarView.dayCellActionsDelegate?.dayCellTapped(date: dayCell.date!)
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numDays = numOfDaysByMonth[calendarView.showingMonthIndex]
        let num = numDays + firstWeekdayOfMonth-1
        return num
    }
    
    //MARK: - Initializers
    init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 250), collectionViewLayout: layout)
        setupView()
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
        
    }
    
}
