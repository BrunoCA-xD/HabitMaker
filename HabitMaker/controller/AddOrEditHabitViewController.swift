//
//  AddHabitViewController.swift
//  HabitMaker
//
//  Created by Bruno Cardoso Ambrosio on 18/04/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//

import UIKit


protocol AddOrEditHabitViewControllerDelegate: class {
    func addHabit(_ item: Habit)
    func editHabit(_ item: Habit)
}

extension AddOrEditHabitViewControllerDelegate {
    func addHabit(_ item: Habit) {}
    func editHabit(_ item: Habit) {}
}

class AddOrEditHabitViewController: UIViewController {
    
    //MARK: - Outlets
    let tableview: UITableView = {
        let tv = UITableView(frame: CGRect(), style: .grouped)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    var confirmItem: UIBarButtonItem!
    
    //MARK: - Attributes
    weak var delegate: AddOrEditHabitViewControllerDelegate?
    var habitDAO = HabitDAO()
    var canEdit = false
    var habit: Habit! {
        didSet{
            if isEditingHabit {
                canEdit = habit.completions!.count == 0
            }
        }
    }
    var successfullPhrase: String = ""
    var isEditingHabit = false
    
    var selectedItem: GoalCriterion?{
        didSet {
            if selectedItem != nil {
                habit.goalCriterion = selectedItem!
                tableview.reloadRows(at: [IndexPath(row: 1, section: 1)], with: .automatic)
                updateSectionFooter()
            }
        }
    }
    private lazy var pickerViewPresenter: PickerViewPresenter<GoalCriterion> = {
        let items = GoalCriterion.allCases.map {
            GenericRow<GoalCriterion>(type: $0, showText: $0.showValue)
        }
        let pickerViewPresenter = PickerViewPresenter<GoalCriterion>(withItems: items)
        pickerViewPresenter.pickerDelegate = self
        pickerViewPresenter.selectedItem = items.first
        return pickerViewPresenter
    }()
    
    //MARK: - View life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalTransitionStyle = .coverVertical
        
        view.addSubview(tableview)
        if !isEditingHabit {
            habit = habitDAO.genNew()
        }
        setupNavigation()
        setupConstraints()
        
        tableview.delegate = self
        tableview.dataSource = self
        tableview.tableFooterView = UIView()
        
        self.view.addSubview(pickerViewPresenter)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //reloads the tableviewData
        super.viewWillAppear(animated)
        tableview.reloadData()
    }
    
    //MARK: - Setup's
    func setupNavigation() {
        let titleEnumOption: AddOrEditHabitStrings = isEditingHabit ? .editModeTitle : .addModeTitle
        navigationItem.title = titleEnumOption.localized()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.label]
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.cancelTapped))
        self.navigationItem.leftBarButtonItems = [cancelItem]
        confirmItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(self.confirmTapped))
        if !isEditingHabit {
            confirmItem.isEnabled = false
        }
        self.navigationItem.rightBarButtonItems = [confirmItem]
    }
    
    fileprivate func setupConstraints() {
        //MARK: tableview constraints
        tableview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
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
        habit.title = title
    }
    
    @objc func numberTextFieldDidChange(_ textField: UITextField) {
        confirmItem.isEnabled = checkFields()
        guard textField.text != nil,
            !textField.text!.isEmpty,
            let number = Double(textField.text!)
        else{ return }
        habit.goalNumber = number
        updateSectionFooter()
    }
    
    @objc func actionTextFieldDidChange(_ textField: UITextField) {
        confirmItem.isEnabled = checkFields()
        guard textField.text != nil,
            !textField.text!.isEmpty
        else{ return }
        habit.goalAction = textField.text!
        updateSectionFooter()
    }
    
    @objc func unitTextFieldDidChange(_ textField: UITextField) {
        confirmItem.isEnabled = checkFields()
        guard textField.text != nil,
            !textField.text!.isEmpty
        else{ return }
        habit.goalUnit = textField.text!
        updateSectionFooter()
    }
    
    @objc func cancelTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func confirmTapped() {
        if isEditingHabit {
            delegate?.editHabit(habit)
        }else {
            if habit.goalCriterion == nil  {
                let criterion = pickerViewPresenter.selectedItem?.type
                habit.goalCriterion = criterion
            }
            delegate?.addHabit(habit)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func checkFields() -> Bool  {
        var someFieldFailed = false
        var indices: [IndexPath] = [
            IndexPath(row: 0, section: 0)
        ]
        if habit.completionType == .numeric {
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
extension AddOrEditHabitViewController:  UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 && indexPath.row == 1 {
            if isEditingHabit && !canEdit {return}
            let vc = HabitTypeSelectorTableViewController()
            vc.delegate = self
            vc.selected = habit.completionType
            navigationController?.show(vc, sender: self)
        }else if indexPath.section == 1 && indexPath.row == 1{
            let itemSelected = habit.goalCriterion ?? GoalCriterion.lessThanOrEqual
            pickerViewPresenter.selectedItem = GenericRow<GoalCriterion>(type:itemSelected, showText: itemSelected.showValue)
            pickerViewPresenter.showPicker()
        }
    }
}

//MARK: - UITableViewDataSource
extension AddOrEditHabitViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if habit.completionType == .yesNo && section == 1 {
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
                cell.label.text = AddOrEditHabitStrings.fieldTitle.localized()
                cell.value.placeholder = AddOrEditHabitStrings.placeholderTitle.localized()
                cell.value.addTarget(self, action: #selector(Self.titleTextFieldDidChange(_:)), for: .allEditingEvents)
                if isEditingHabit {
                    cell.value.text = habit.title
                }
                return cell
            }else{
                let cell = UITableViewCell(style: .value1, reuseIdentifier: "type")
                cell.textLabel?.text = AddOrEditHabitStrings.fieldType.localized()
                cell.detailTextLabel?.text = habit.completionType.description
                cell.accessoryType = .disclosureIndicator
                return cell
            }
        }else {
            switch row {
                case 0:
                    let cell = FormFieldTableViewCell()
                    cell.label.text = AddOrEditHabitStrings.fieldAction.localized()
                    cell.value.placeholder = AddOrEditHabitStrings.placeholderAction.localized()
                    cell.value.returnKeyType = .next
                    cell.value.addTarget(self, action: #selector(Self.actionTextFieldDidChange(_:)), for: .allEditingEvents)
                    if isEditingHabit {
                        cell.value.text = habit.goalAction
                    }
                    return cell
                case 1 :
                    let cell = UITableViewCell(style: .value1, reuseIdentifier: "metric")
                    cell.textLabel?.text = AddOrEditHabitStrings.fieldMetric.localized()
                    cell.detailTextLabel?.text = (habit.goalCriterion ?? GoalCriterion.lessThanOrEqual).showValue
                    return cell
                case 2:
                    let cell = FormFieldTableViewCell()
                    cell.label.text = AddOrEditHabitStrings.fieldNumber.localized()
                    cell.value.placeholder = AddOrEditHabitStrings.placeholderNumber.localized()
                    cell.value.keyboardType = .numberPad
                    cell.value.addDoneButtonOnKeyboard()
                    cell.value.addTarget(self, action: #selector(Self.numberTextFieldDidChange(_:)), for: .allEditingEvents)
                    if isEditingHabit {
                        cell.value.text = "\(habit.goalNumber)"
                    }
                    return cell
                case 3:
                    let cell = FormFieldTableViewCell()
                    cell.label.text = AddOrEditHabitStrings.fieldUnit.localized()
                    cell.value.placeholder = AddOrEditHabitStrings.placeholderUnit.localized()
                    cell.value.addTarget(self, action: #selector(Self.unitTextFieldDidChange(_:)), for: .allEditingEvents)
                    if isEditingHabit {
                        cell.value.text = habit.goalUnit
                    }
                    return cell
                default:
                    return UITableViewCell()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
           return 0
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        if section == 1 && habit.completionType == .numeric {
            label.text = AddOrEditHabitStrings.goalQuestion.localized()
            label.tintColor = .secondaryLabel
            label.dynamicFont = UIFont.preferredFont(forTextStyle: .footnote)
            return label
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == 1 && habit.completionType == .numeric {
            return successfullPhrase
        }
        return nil
    }
    
}

//MARK: - TableView Helpers
extension AddOrEditHabitViewController{
    
    private func updateSectionFooter() {
        
        let action = habit.goalAction ?? " "
        let goalCriterion = habit.goalCriterion ?? GoalCriterion.lessThanOrEqual
        let criterion = goalCriterion.showValue
        let number = habit.goalNumber
        let unit = habit.goalUnit ?? " "
        let phrasePrefix = AddOrEditHabitStrings.successfullPhrasePrefix.localized()
        
        successfullPhrase = "\(phrasePrefix) "
        
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

extension AddOrEditHabitViewController: HabitTypeSelectorActions {
    //Item Selection on the view controller selector
    func didSelect( type: CompletionType) {
        habit.completionType = type
        updateTableView {
            self.tableview.reloadSections(IndexSet(arrayLiteral: 1), with: .automatic)
            self.tableview.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .automatic)
        }
        confirmItem.isEnabled = checkFields()
    }
}

extension AddOrEditHabitViewController: PickerViewPresenterDelegate {
    //Item Selection on pickerView
    func selected(item: Any) {
        if let row = item as? GenericRow<GoalCriterion> {
            let criterion = row.type
            if habit.goalCriterion != criterion {
                habit.goalCriterion = criterion
                self.tableview.reloadRows(at: [IndexPath(row: 1, section: 1)], with: .automatic)
            }
        }
    }
}
