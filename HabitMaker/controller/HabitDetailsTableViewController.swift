//
//  HabitDetailsTableViewController.swift
//  HabitMaker
//
//  Created by Bruno Cardoso Ambrosio on 27/04/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//

import UIKit

class HabitDetailsTableViewController: UIViewController {

    //MARK: - Outlets
    var headerView: ModalHeaderView!
    let tableview: UITableView = {
        let tv = UITableView(frame: CGRect(), style: .grouped)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    var calendarView: CalendarView!
    
    var habit: Habit?
    
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
        calendarView = CalendarView()
        
        tableview.delegate = self
        tableview.dataSource = self
        tableview.tableFooterView = UIView()
        
        setupConstraints()
        
        headerView.headerTitle.text = habit?.title

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
            return 350
        }
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
}
extension HabitDetailsTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 1 ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = CalendarViewTableViewCell()
            return cell
        }else if indexPath.section == 1 {
            switch indexPath.row {
            case 0:
                let cell = UITableViewCell(style: .value1, reuseIdentifier: "total")
                cell.textLabel?.text = "Total times done"
                cell.detailTextLabel?.text = "38"
                return cell
            case 1:
                let cell = UITableViewCell(style: .value1, reuseIdentifier: "total")
                cell.textLabel?.text = "Started at"
                cell.detailTextLabel?.text = habit?.createdAt?.dateValue
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
        self.dismiss(animated: true, completion: nil)
    }
}
