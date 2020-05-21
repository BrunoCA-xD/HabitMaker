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
    let tableview: UITableView = {
        let tv = UITableView(frame: CGRect(), style: .grouped)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    var confirmItem: UIBarButtonItem!
    
    //MARK: - Attributes
    var delegate: AddHabitViewControllerDelegate!
    var habitDAO = HabitDAO()
    var newHabit: Habit!
    var successfullPhrase: String = ""
    
    var selectedItem: GoalCriterion?{
        didSet {
            if selectedItem != nil {
                newHabit.goalCriterion = selectedItem!.rawValue
                tableview.reloadRows(at: [IndexPath(row: 1, section: 1)], with: .automatic)
                updateSectionFooter()
            }
        }
    }
    private lazy var pickerViewPresenter: PickerViewPresenter = {
        let pickerViewPresenter = PickerViewPresenter()
        pickerViewPresenter.didSelectItem = { [weak self] item in
            self?.selectedItem = item
        }
        return pickerViewPresenter
    }()
    
    //MARK: - View life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalTransitionStyle = .coverVertical
        
        view.addSubview(tableview)
        
        newHabit = habitDAO.genNew()
        setupNavigation()
        setupConstraints()
        
        tableview.delegate = self
        tableview.dataSource = self
        tableview.tableFooterView = UIView()
        
        self.view.addSubview(pickerViewPresenter)
        
    }
    
    //MARK: - Setup's
    func setupNavigation() {
        navigationItem.title = "New Habit"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.label]
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.cancelTapped))
        self.navigationItem.leftBarButtonItems = [cancelItem]
        confirmItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(self.confirmTapped))
        confirmItem.isEnabled = false
        self.navigationItem.rightBarButtonItems = [confirmItem]
    }
    
    fileprivate func setupConstraints() {
        //MARK: tableview constraints
        tableview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    //MARK: - Actions
    @objc func titleTextFieldDidChange(_ textField: UITextField) {
        confirmItem.isEnabled = checkFields()
        guard textField.text != nil,
            !textField.text!.isEmpty,
            let title = textField.text
        else{ return }
        newHabit.title = title
    }
    
    @objc func numberTextFieldDidChange(_ textField: UITextField) {
        confirmItem.isEnabled = checkFields()
        guard textField.text != nil,
            !textField.text!.isEmpty,
            let number = Int64(textField.text!)
        else{ return }
        newHabit.goalNumber = number
        updateSectionFooter()
    }
    
    @objc func actionTextFieldDidChange(_ textField: UITextField) {
        confirmItem.isEnabled = checkFields()
        guard textField.text != nil,
            !textField.text!.isEmpty
        else{ return }
        newHabit.goalAction = textField.text!
        updateSectionFooter()
    }
    
    @objc func unitTextFieldDidChange(_ textField: UITextField) {
        confirmItem.isEnabled = checkFields()
        guard textField.text != nil,
            !textField.text!.isEmpty
        else{ return }
        newHabit.goalUnit = textField.text!
        updateSectionFooter()
    }
    
    @objc func cancelTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func confirmTapped() {
        delegate.addHabit(newHabit)
        self.dismiss(animated: true, completion: nil)
    }
    
    func checkFields() -> Bool  {
        var someFieldFailed = false
        var indices: [IndexPath] = [
            IndexPath(row: 0, section: 0)
        ]
        if newHabit.type == CompletionType.numeric.rawValue {
            indices.append(contentsOf: [
                IndexPath(row: 0, section: 1),
                IndexPath(row: 1, section: 1),
                IndexPath(row: 2, section: 1),
                IndexPath(row: 3, section: 1)
            ])
        }
        for i in 0..<indices.count {
            let index = indices[i]
            guard
                let field = getFormField(index),
                field.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == true
                else {continue}
            someFieldFailed = true
            break
        }
        
        return !someFieldFailed
    }
    
}

//MARK: - UITableViewDelegate
extension AddHabitViewController:  UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 1 {
            let vc = HabitTypeSelectorTableViewController()
            vc.delegate = self
            vc.selected = CompletionType(rawValue: newHabit.type)!
            navigationController?.show(vc, sender: self)
        }else if indexPath.section == 1 && indexPath.row == 1{
            pickerViewPresenter.selectedItem = GoalCriterion(rawValue: newHabit.goalCriterion ?? GoalCriterion.lessThanOrEqual.rawValue )
            pickerViewPresenter.showPicker()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - UITableViewDataSource
extension AddHabitViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if newHabit.type == CompletionType.yesNo.rawValue && section == 1 {
            return 0
        }
        
        return section%2==0 ? 2 : 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        if section == 0 {
            if row == 0{
                let cell = FormFieldTableViewCell()
                cell.label.text = "Title"
                cell.value.placeholder = "Habit title"
                cell.value.addTarget(self, action: #selector(Self.titleTextFieldDidChange(_:)), for: .allEditingEvents)
                return cell
            }else{
                let cell = UITableViewCell(style: .value1, reuseIdentifier: "type")
                cell.textLabel?.text = "Type"
                cell.detailTextLabel?.text = CompletionType(rawValue: newHabit.type)?.description
                cell.accessoryType = .disclosureIndicator
                return cell
            }
        }else {
            switch row {
            case 0:
                let cell = FormFieldTableViewCell()
                cell.label.text = "Action"
                cell.value.placeholder = "e.g: run, drink, read..."
                cell.value.returnKeyType = .next
                cell.value.addTarget(self, action: #selector(Self.actionTextFieldDidChange(_:)), for: .allEditingEvents)
                return cell
            case 1 :
                let cell = UITableViewCell(style: .value1, reuseIdentifier: "metric")
                cell.textLabel?.text = "Metric"
                cell.detailTextLabel?.text = GoalCriterion(rawValue: newHabit.goalCriterion ?? GoalCriterion.lessThanOrEqual.rawValue)?.showValue
                return cell
            case 2:
                let cell = FormFieldTableViewCell()
                cell.label.text = "Number"
                cell.value.placeholder = "e.g: 5, 10, 20"
                cell.value.keyboardType = .numberPad
                cell.value.addDoneButtonOnKeyboard()
                cell.value.addTarget(self, action: #selector(Self.numberTextFieldDidChange(_:)), for: .allEditingEvents)
                
                return cell
            case 3:
                let cell = FormFieldTableViewCell()
                cell.label.text = "Unit"
                cell.value.placeholder = "e.g: pages, cups, miles"
                cell.value.addTarget(self, action: #selector(Self.unitTextFieldDidChange(_:)), for: .allEditingEvents)
                return cell
            default:
                return UITableViewCell()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 && newHabit.type == CompletionType.numeric.rawValue {
            return "When is a day successfull?"
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == 1 && newHabit.type == CompletionType.numeric.rawValue {
            return successfullPhrase
        }
        return nil
    }
    
}

//MARK: - TableView Helpers
extension AddHabitViewController{
    
    private func updateSectionFooter() {
        
        let action = newHabit.goalAction ?? "do"
        let goalCriterion = GoalCriterion(rawValue: newHabit.goalCriterion ?? GoalCriterion.lessThanOrEqual.rawValue)
        let criterion = goalCriterion?.showValue ?? GoalCriterion.lessThanOrEqual.showValue
        let number = newHabit.goalNumber
        let unit = newHabit.goalUnit ?? "Units"
        
        successfullPhrase = "When I "
        
        successfullPhrase += action + " "
        successfullPhrase += criterion + " "
        successfullPhrase += "\(number)" + " "
        successfullPhrase += unit
        
        updateTableView {
            if let containerView = self.tableview.footerView(forSection: 1) {
                containerView.textLabel!.text = self.successfullPhrase
                containerView.sizeToFit()
            }
        }
    }
    
    fileprivate func updateTableView(codeBlock: @escaping () -> ()) {
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.tableview.beginUpdates()
            codeBlock()
            self.tableview.endUpdates()
        })
    }
    
    fileprivate func getFormField(_ indexPath: IndexPath) -> UITextField? {
        
        guard let cell = tableview.cellForRow(at: indexPath) as? FormFieldTableViewCell else {return nil}
        return cell.value
    }
}

extension AddHabitViewController: HabitTypeSelectorActions {
    func didSelect( type: CompletionType) {
        newHabit.type = type.rawValue
        updateTableView {
            self.tableview.reloadSections(IndexSet(arrayLiteral: 1), with: .automatic)
            self.tableview.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .automatic)
        }
        confirmItem.isEnabled = checkFields()
    }
}
