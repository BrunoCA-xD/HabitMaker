//
//  AddHabitViewController.swift
//  HabitMaker
//
//  Created by Bruno Cardoso Ambrosio on 18/04/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//

import UIKit


protocol AddHabitViewControllerDelegate {
    func addHabit(_ item: Habit)
}

class AddHabitViewController: UIViewController {
    
    //MARK: - Outlets
    var headerView: ModalHeaderView!
    let tableview: UITableView = {
        let tv = UITableView(frame: CGRect(), style: .grouped)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    //MARK: - cell outltets references
    var picker: UIDatePicker? = nil
    var label: UILabel? = nil
    
    //MARK: - Attributes
    var delegate: AddHabitViewControllerDelegate!
    var habitDAO = HabitDAO()
    var newHabit: Habit!
    
    //MARK: - View life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalTransitionStyle = .coverVertical

        headerView = {
            let v = ModalHeaderView(needsConfirmButton: true)
            v.headerTitle.text = "New Habit"
            v.delegate = self
            v.backgroundColor = UIColor.systemBackground
            return v
        }()
        
        view.addSubview(headerView)
        view.addSubview(tableview)
        
        setupConstraints()
        
        tableview.delegate = self
        tableview.dataSource = self
        tableview.tableFooterView = UIView()
        
        newHabit = habitDAO.genNew()
        
    }
    
    //MARK: - Setup's
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
    
    //MARK: - Actions
    @objc func reminderChanged(sender: UISwitch) {
       let pickerHeaderIndex = IndexPath(row: 1, section: 1)
        guard let picker = self.picker, let cell = getPickerHeaderCell(pickerHeaderIndex)  else {return}
        if sender.isOn {
            picker.isHidden = !sender.isOn
            cell.isHidden = !cell.isHidden
            updateTableView()
        }else {
            picker.isHidden = !sender.isOn
            cell.isHidden = !cell.isHidden
            cell.resetIcon()
            updateTableView()
        }
    }
    
    @objc func dateChanged(sender: UIDatePicker) {
        let pickerHeaderIndex = IndexPath(row: 1, section: 1)
        guard let cell = getPickerHeaderCell(pickerHeaderIndex) else {return}
        cell.textLabel?.text = "At time: \(sender.date.timeValue)"
    }
}

//MARK: - UITableViewDelegate
extension AddHabitViewController:  UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 1 {
            if indexPath.row == 1 {
                guard let label = label, !label.isHidden else {return 0.0}
                return UITableView.automaticDimension
            }
            if indexPath.row == 2 {
                guard let picker = picker, !picker.isHidden else { return  0.0 }
                return 216.0
            }
        }
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? PickerHeaderTableViewCell,
            let picker = picker else {return}
        cell.toggleIcon()
        tableView.deselectRow(at: indexPath, animated: true)
        picker.isHidden = !picker.isHidden
        cell.textLabel?.text = "At time: \(picker.date.timeValue)"
        updateTableView()
        
    }
}

//MARK: - UITableViewDataSource
extension AddHabitViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section%2==0 ? 1 : 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = FormFieldTableViewCell()
            cell.label.text = "Title"
            cell.value.placeholder = "Habit title"
            return cell
        }else {
            switch indexPath.row {
            case 0:
                let cell = SwitchTableViewCell()
                cell.icon = UIImage(systemName: "bell.fill")
                cell.label.text = "Set reminder"
                cell.onSwitch.isOn = false
                cell.onSwitch.addTarget(self, action: #selector(Self.reminderChanged), for: .valueChanged)
                return cell
            case 1 :
                let cell = PickerHeaderTableViewCell()
                cell.textLabel?.text = "At time"
                cell.isHidden = true
                label = cell.textLabel
                return cell
            case 2:
                let cell = DatePickerTableViewCell()
                cell.picker.datePickerMode = .time
                cell.picker.addTarget(self, action: #selector(Self.dateChanged), for: .valueChanged)
                cell.picker.isHidden = true
                picker = cell.picker
                return cell
            default:
                return UITableViewCell()
            }
        }
    }
    
}

//MARK: - TableView Helpers
extension AddHabitViewController{
    
    fileprivate func updateTableView() {
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.tableview.beginUpdates()
            self.tableview.endUpdates()
        })
    }
    
    fileprivate func getPickerHeaderCell(_ indexPath: IndexPath) -> PickerHeaderTableViewCell? {
        
        guard let cell = tableview.cellForRow(at: indexPath) as? PickerHeaderTableViewCell else {return nil}
        return cell
    }
    
    fileprivate func getFormField(_ indexPath: IndexPath) -> UITextField? {
        
        guard let cell = tableview.cellForRow(at: indexPath) as? FormFieldTableViewCell else {return nil}
        return cell.value
    }
}

extension AddHabitViewController: ModalHeaderActionsDelegate {
    func closeButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func confirmButtonTapped() {
        let titleIndex = IndexPath(row: 0, section: 0)
        guard
            let habitField = getFormField(titleIndex) else {return}
        guard
            let habitTitle = habitField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
            !habitTitle.isEmpty
            else {
                AlertUtility.validationAlertWithTitle(title: "Invalid data", message: "The field is required!", ViewController: self, input: habitField)
                return
        }
        
        newHabit.title = habitTitle
        delegate.addHabit(newHabit)
        self.dismiss(animated: true, completion: nil)
    }
    
}
