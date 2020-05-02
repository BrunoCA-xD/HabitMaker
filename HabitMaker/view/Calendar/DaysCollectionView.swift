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

class DaysCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    weak var calendarView: CalendarView!
    var numOfDaysByMonth = Date.numOfDaysByMonth(inYear: nil)
   
    var presentMonthIndex = 0
    var presentYear = 0
    var todaysDate = 0
    var firstWeekdayOfMonth = 0 //(Sunday-Saturday 1-7)
    var habit : Habit!{
        didSet {
            refreshData()
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numDays = numOfDaysByMonth[calendarView.showingMonthIndex-1]
        let num = numDays + firstWeekdayOfMonth-1
        return num
    }
    
    fileprivate func formatTodaysCell(_ cell: CalendarDayCollectionViewCell) {
        cell.backgroundColor = UIColor.systemBlue
        cell.lbl.textColor =  UIColor.white
        cell.layer.cornerRadius = 15.0
    }
    
    fileprivate func formatNormalCells(_ cell: CalendarDayCollectionViewCell) {
        cell.lbl.textColor = UIColor.label
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarDayCollectionViewCell.defaultReuseIdentifier,for: indexPath) as! CalendarDayCollectionViewCell
        if indexPath.item <= firstWeekdayOfMonth-2 {
            cell.isHidden = true
        }else {
            let calcDate = indexPath.row-firstWeekdayOfMonth+2
            cell.isHidden = false
            cell.configure(day: calcDate, components:  DateComponents(year:calendarView.showingYear,month:calendarView.showingMonthIndex))
            if calcDate == todaysDate &&
                calendarView.showingMonthIndex == presentMonthIndex &&
                calendarView.showingYear == presentYear {
                formatTodaysCell(cell)
            }else {
                formatNormalCells(cell)
            }
            if habit.completionsContains(cell.date!){
                cell.layer.cornerRadius = 15.0
                cell.layer.borderWidth = 1.0
                cell.layer.borderColor = UIColor.systemGreen.cgColor
                cell.layer.masksToBounds = true
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dayCell = collectionView.cellForItem(at: indexPath) as! CalendarDayCollectionViewCell
        calendarView.dayCellActionsDelegate?.dayCellTapped(date: dayCell.date!)
        collectionView.reloadData()
    }
    
    
    init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 250), collectionViewLayout: layout)
        initializeView()
    }
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        initializeView()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeView()
        
    }
    
    func initializeView(){
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
        
        presentMonthIndex = Calendar.current.component(.month, from: Date())
        
        presentYear = Calendar.current.component(.year, from: Date())
        
        reloadData()
    }
    
    func getFirstWeekday() -> Int{
        let monthDate = Calendar.current.date(from: DateComponents(year: calendarView.showingYear, month: calendarView.showingMonthIndex,day:1))!
        
        let day = Calendar.current.component(.weekday, from: monthDate )
        
        return day == 7 ? 1 : day
    }
    
}