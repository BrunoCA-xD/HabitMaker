//
//  CalendarView.swift
//  HabitMaker
//
//  Created by Bruno Cardoso Ambrosio on 25/04/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//

import UIKit

protocol dayCellClicked{
    func didDayCellClicked(cell: CalendarDayCollectionViewCell)
}

class DaysCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    weak var calendarView: CalendarView!
    var numOfDaysByMonth = Date.numOfDaysByMonth(inYear: nil)
   
    var presentMonthIndex = 0
    var presentYear = 0
    var todaysDate = 0
    var firstWeekdayOfMonth = 0 //(Sunday-Saturday 1-7)
    var habit : Habit!
    var dayCellDelegate: dayCellClicked? = nil
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numDays = numOfDaysByMonth[calendarView.showingMonthIndex-1]
        let num = numDays + firstWeekdayOfMonth-1
        return num
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
                cell.backgroundColor = UIColor.systemYellow
                cell.lbl.textColor = UIColor.labelOpposite
            }else {
                cell.backgroundColor = UIColor.systemBackground
                cell.lbl.textColor = UIColor.label
            }
//            if habit.lastCompletionDate.contains(cell.date!){
//                cell.contentView.layer.cornerRadius = 15.0
//                cell.contentView.layer.borderWidth = 1.0
//                cell.contentView.layer.borderColor = UIColor.green.cgColor
//                cell.contentView.layer.masksToBounds = true
//            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dayCell = collectionView.cellForItem(at: indexPath) as! CalendarDayCollectionViewCell
        dayCellDelegate?.didDayCellClicked(cell: dayCell)
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
        self.backgroundColor = .systemBackground
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
        
        for cell in self.visibleCells as! [CalendarDayCollectionViewCell]{
            cell.layer.borderWidth = 0
            cell.layer.borderColor = .none
            cell.layer.backgroundColor = .none
//            cell.lbl.textColor = UIColor.darkText
            if let date = cell.date{
//                if habit.lastCompletionDate.contains(date){
//                    cell.contentView.layer.cornerRadius = 15.0
//                    cell.contentView.layer.borderWidth = 1.0
//                    cell.contentView.layer.borderColor = UIColor.green.cgColor
//                    cell.contentView.layer.masksToBounds = true
//                }
            }
        }
    }
    
    func getFirstWeekday() -> Int{
        let monthDate = Calendar.current.date(from: DateComponents(year: calendarView.showingYear, month: calendarView.showingMonthIndex,day:1))!
        
        let day = Calendar.current.component(.weekday, from: monthDate )
        
        return day == 7 ? 1 : day
    }
    
}
