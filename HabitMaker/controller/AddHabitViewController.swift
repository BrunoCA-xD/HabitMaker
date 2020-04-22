//
//  AddHabitViewController.swift
//  HabitMaker
//
//  Created by Bruno Cardoso Ambrosio on 18/04/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//

import UIKit

class AddHabitViewController: UIViewController {
    
    let headerView: ModalHeaderView = {
        let v = ModalHeaderView(needsConfirmButton: true)
        v.headerTitle.text = "New Habit"
        v.closeButton.addTarget(self, action: #selector(Self.closeModalTapped), for: .touchDown)
        v.confirmButton!.addTarget(self, action: #selector(Self.confirmButtonTapped), for: .touchDown)
        v.backgroundColor = UIColor.systemBackground
        return v
    }()
    
    let tableview: UITableView = {
        let tv = UITableView(frame: CGRect(), style: .grouped)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    var picker: UIDatePicker? = nil
    var label: UILabel? = nil
    
    
    
    fileprivate func setupConstraints() {
        //MARK: headerView
        headerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        //MARK: tableview
        tableview.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalTransitionStyle = .coverVertical
        
        view.addSubview(headerView)
        view.addSubview(tableview)
        
        setupConstraints()
        
        tableview.delegate = self
        tableview.dataSource = self
        tableview.tableFooterView = UIView()
        
    }
    
    @objc private func closeModalTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func confirmButtonTapped() {
        print("Salvar")
    }
}

extension AddHabitViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section%2==0 ? 1 : 3
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
        updateTableView()
        
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
                //Collapsable cell to pick
                let cell = SwitchTableViewCell()
                cell.icon = UIImage(systemName: "bell.fill")
                cell.label.text = "Set reminder"
                cell.onSwitch.isOn = true
                return cell
            }
        }
    }
    
    fileprivate func updateTableView() {
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.tableview.beginUpdates()
            self.tableview.endUpdates()
        })
    }
    
    fileprivate func getPickerHeaderCell() -> PickerHeaderTableViewCell? {
        let index = IndexPath(row: 1, section: 1)
        guard let cell = tableview.cellForRow(at: index) as? PickerHeaderTableViewCell else {return nil}
        return cell
    }
    
    @objc func reminderChanged(sender: UISwitch) {
       
        guard let picker = self.picker, let cell = getPickerHeaderCell()  else {return}
        if sender.isOn {
            picker.isHidden = !sender.isOn
            cell.isHidden = !cell.isHidden

            updateTableView()
        }else {
            picker.isHidden = !sender.isOn
            cell.isHidden = !cell.isHidden
            updateTableView()
        }
    }
    
    @objc func dateChanged(sender: UIDatePicker) {
        guard let cell = getPickerHeaderCell() else {return}
        cell.textLabel?.text = "\(sender.date)"
    }
}

