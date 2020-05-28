//
//  AddNumericCompletionTableViewController.swift
//  HabitMaker
//
//  Created by Bruno Cardoso Ambrosio on 22/05/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//

import UIKit

protocol AddNumericCompletionDelegate: class {
    func didSave(vc: AddNumericCompletionTableViewController, newCompletion: Completion, oldCompletion: Completion?)
}

class AddNumericCompletionTableViewController: UITableViewController {

    //MARK: - Attributes
    var date: Date?
    var completion: Completion!
    var oldCompletion: Completion? = nil
    var habit: Habit?
    weak var delegate: AddNumericCompletionDelegate?
    var successfullPhrase: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        
        if habit != nil && date != nil && completion == nil{
            completion = Completion(entity: Completion.entity(), insertInto: CoreDataDAO.shared.persistentContainer.viewContext)
            completion?.date = date
        }
        updateSectionHeader()
        tableView.tableFooterView = UIView()
    }
    
    func setupNavigation() {
        navigationItem.title = "Set number"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.label]
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.cancelTapped))
        self.navigationItem.leftBarButtonItems = [cancelItem]
        let confirmItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(self.confirmTapped))
        self.navigationItem.rightBarButtonItems = [confirmItem]
    }
    
    @objc func cancelTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func confirmTapped() {
        delegate?.didSave(vc:self, newCompletion: completion, oldCompletion: oldCompletion )
        
    }
    
    @objc func achivedNumberChanged(stepper: UIStepper) {
        let achievedNumber = stepper.value
        completion?.achievedNumber = achievedNumber
        setIsAchived(achievedNumber)
    }
    
    func setIsAchived(_ achievedNumber: Double) {
        let goalNumber = completion?.habit?.goalNumber ?? 0.0
        let criterionAsString = completion?.habit?.goalCriterion ?? ""
        let goalCriterion = GoalCriterion(rawValue: criterionAsString)
        var isAchieved = false
        switch goalCriterion {
        case .lessThanOrEqual:
            isAchieved = achievedNumber <= goalNumber
            break
        case .greaterThanOrEqual:
            isAchieved = achievedNumber >= goalNumber
            break
        default:
            isAchieved =  achievedNumber == goalNumber
        }
        completion?.isAchived = isAchieved
    }
    
   
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
      return UITableView.automaticDimension
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var resultCell: UITableViewCell! = UITableViewCell()
        let row =  indexPath.row
        switch row {
        case 1:
            let cell = StepperTableViewCell()
            cell.icon = UIImage(systemName: "pin.fill")
            cell.stepper.value = completion.achievedNumber
            cell.label.text = "\(cell.stepper.value)"
            cell.stepper.addTarget(self, action: #selector(Self.achivedNumberChanged(stepper:)), for: .valueChanged)
            resultCell = cell
        case 3:
            let cell  = FormTextViewFieldTableViewCell()
            cell.label.text = "Comment"
            cell.value.delegate = self
            resultCell = cell
        case 2:
            resultCell = UITableViewCell(style: .value1, reuseIdentifier: "")
            resultCell.selectionStyle = .none
            resultCell.textLabel?.text = "Date"
            resultCell.detailTextLabel?.text = date?.dateValue
        default: //0
            resultCell = UITableViewCell(style: .subtitle, reuseIdentifier: "")
            resultCell.selectionStyle = .none
            resultCell.textLabel?.text = "Goal:"
            resultCell.textLabel?.dynamicFont = UIFont.systemFont(ofSize: 20)
            let mainTextSize = resultCell.textLabel?.font.pointSize ?? 16
            resultCell.detailTextLabel?.dynamicFont = UIFont.systemFont(ofSize: mainTextSize-2)
            resultCell.detailTextLabel?.text = successfullPhrase
        }
        return resultCell
    }

    private func updateSectionHeader() {
        
        let action = habit?.goalAction ?? "do"
        let goalCriterion = GoalCriterion(rawValue: habit?.goalCriterion ?? GoalCriterion.lessThanOrEqual.rawValue)
        let criterion = goalCriterion?.showValue ?? GoalCriterion.lessThanOrEqual.showValue
        let number = habit?.goalNumber ?? 0.0
        let unit = habit?.goalUnit ?? "Units"
        
        successfullPhrase = ""
        
        successfullPhrase += action + " "
        successfullPhrase += criterion + " "
        successfullPhrase += "\(number)" + " "
        successfullPhrase += unit
        
        updateTableView {
            self.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        }
    }
    
    fileprivate func updateTableView(codeBlock: (() -> ())? = nil ) {
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.tableView.beginUpdates()
            if let codeBlock = codeBlock {
                codeBlock()
            }
            self.tableView.endUpdates()
        })
    }
}

extension AddNumericCompletionTableViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        updateTableView(codeBlock: nil)
    }
}
