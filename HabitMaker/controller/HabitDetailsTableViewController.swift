//
//  HabitDetailsTableViewController.swift
//  HabitMaker
//
//  Created by Bruno Cardoso Ambrosio on 27/04/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//

import UIKit

protocol HabitDetailsTableViewControllerDelegate: class {
    func close(viewController: HabitDetailsTableViewController, item: Habit)
}

class HabitDetailsTableViewController: UIViewController {
    
    //MARK: - Outlets
    var headerView: ModalHeaderView!
    let tableview: UITableView = {
        let tv = UITableView(frame: CGRect(), style: .grouped)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    weak var delegate: HabitDetailsTableViewControllerDelegate?
    
    var habitDAO = HabitDAO()
    var habit: Habit!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView = {
            let v = ModalHeaderView(needsConfirmButton: false)
            v.headerTitle.text = "Habit "
            v.delegate = self
            v.backgroundColor = UIColor.systemBackground
            return v
        }()
        view.addSubview(headerView)
        view.addSubview(tableview)
        
        tableview.delegate = self
        tableview.dataSource = self
        tableview.tableFooterView = UIView()
        tableview.allowsSelection = false
        
        setupConstraints()
        
        headerView.headerTitle.text = habit?.title
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.close(viewController: self, item: habit)
    }
    
    fileprivate func setupConstraints() {
        //MARK: headerView constraints
        headerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        //MARK: tableview constraints
        tableview.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension HabitDetailsTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return 390
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return section == 0 ? nil : UIView()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : UITableView.automaticDimension
    }
}
extension HabitDetailsTableViewController: UITableViewDataSource {
    func reloadData() {
        let indexPahts: [IndexPath] = [
            IndexPath(row: 0, section: 1),
            IndexPath(row: 1, section: 1),
            IndexPath(row: 2, section: 1)
        ]
        tableview.reloadRows(at: indexPahts, with: .automatic)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 1 ? 4 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = CalendarViewTableViewCell()
            cell.calendarView.daysCollection?.habit = habit
            cell.calendarView.dayCellActionsDelegate = self
            return cell
        }else if indexPath.section == 1 {
            switch indexPath.row {
            case 0:
                let cell = UITableViewCell(style: .value1, reuseIdentifier: "current")
                cell.textLabel?.text = "Current Streak"
                cell.detailTextLabel?.text = "\(habit.currStreak)"
                return cell
            case 1:
                let cell = UITableViewCell(style: .value1, reuseIdentifier: "Best")
                cell.textLabel?.text = "Best Streak"
                cell.detailTextLabel?.text = "\(habit.bestStreak)"
                return cell
            case 2:
                let cell = UITableViewCell(style: .value1, reuseIdentifier: "total")
                cell.textLabel?.text = "Days Tracked"
                cell.detailTextLabel?.text = "\(habit.numberOfCompletions)"
                return cell
            case 3:
                let cell = UITableViewCell(style: .value1, reuseIdentifier: "total")
                cell.textLabel?.text = "Started at"
                cell.detailTextLabel?.text = habit.createdAt?.dateValue
                return cell
            default:
                break
            }
        }
        return UITableViewCell()
    }
    
    
}

extension HabitDetailsTableViewController: ModalHeaderActionsDelegate {
    
    func closeButtonTapped() {
        delegate?.close(viewController: self, item: habit)
    }
}

extension HabitDetailsTableViewController: DayCellActionsDelegate {
   
    fileprivate func reloadCalendar() {
        let cell = tableview.cellForRow(at: IndexPath(item: 0, section: 0)) as? CalendarViewTableViewCell
        cell?.calendarView.daysCollection?.refreshData()
        cell?.calendarView.daysCollection?.reloadData()
        self.reloadData()
    }
    
    func dayCellTapped(date: Date) {
        
        guard let completionType = CompletionType(rawValue: habit.type) else {
            print("error on type")
            return
        }
        var completion = habit.findCompletion(withDate: date)
        if completionType == .numeric {
            let vc = AddNumericCompletionTableViewController()
            vc.habit = habit
            vc.date = date
            
            if completion != nil {
                vc.completion = completion!
                vc.oldCompletion = completion!
            }
            vc.delegate = self
            
            let newNav = UINavigationController(rootViewController: vc)
            self.present(newNav, animated: true, completion: nil)
        }else {
            if completion == nil {
                completion = CompletionDAO().genNew(withHabit: habit)
                completion!.date = date
                completion!.isAchived = true
                habit.addToCompletions(completion!)
            }else {
                if completion?.isAchived == true {
                    completion?.isAchived = false
                }else {
                    habit.removeFromCompletions(completion!)
                    CompletionDAO().delete(completion: completion!)
                }
            }
            habitDAO.calculateStreaks(habit)
            reloadCalendar()
        }
    }
    
}

extension HabitDetailsTableViewController: AddNumericCompletionDelegate {
    func didCancel(vc: AddNumericCompletionTableViewController) {
        vc.dismiss(animated: true, completion: nil)
    }
    func didSave(vc: AddNumericCompletionTableViewController, newCompletion: Completion, oldCompletion: Completion?) {
        vc.dismiss(animated: true, completion: nil)
        if oldCompletion == nil {
            habit.addToCompletions(newCompletion)
        }else {
            habit.removeFromCompletions(oldCompletion!)
            habit.addToCompletions(newCompletion)
        }
        habitDAO.calculateStreaks(habit)
        reloadCalendar()
    }
    func didDelete(vc: AddNumericCompletionTableViewController, oldCompletion: Completion?) {
        vc.dismiss(animated: true, completion: nil)
        habit.removeFromCompletions(oldCompletion!)
        CompletionDAO().delete(completion: oldCompletion!)
        habitDAO.calculateStreaks(habit)
        reloadCalendar()
        
    }
    
}
