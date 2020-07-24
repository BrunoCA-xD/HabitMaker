//
//  habitsTableViewController.swift
//  HabitMaker
//
//  Created by Bruno Cardoso Ambrosio on 16/04/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//

import UIKit

class HabitsTableViewController: UITableViewController {
    
    //MARK: - Attributes
    var habits:[Habit] = []
    var habitDAO = HabitDAO()
    
    //MARK: - view life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupCells()
        view.backgroundColor = .systemBackground
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        habits = habitDAO.listAll()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habits.count
    }
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let habit = habits[indexPath.row]
        let vc = HabitDetailsTableViewController()
        vc.delegate = self
        vc.habit = habit
        tableView.deselectRow(at: indexPath, animated: true)
        let newNav = UINavigationController(rootViewController: vc)
        self.present(newNav, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HabitTableViewCell.defaultReuseIdentifier, for: indexPath) as? HabitTableViewCell else {
            fatalError("HabitTableViewCell could not load")
        }
        
        cell.titleLabel.text = habits[indexPath.row].title
        cell.streakLabel.text = "Streak: \(habits[indexPath.row].currStreak)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let habit = habits[indexPath.row]
        switch editingStyle {
        case .delete:
            habits.remove(at: indexPath.row)
            habitDAO.delete(item: habit)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        default:
            break
        }
    }
    
    //MARK: - Setup's
    func setupNavigation() {
        navigationItem.title = "Habits"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.label]
        
        let addHabitItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addHabitTapped))
        self.navigationItem.rightBarButtonItems = [addHabitItem]
        
    }
    
    func setupCells() {
        tableView.register(HabitTableViewCell.self, forCellReuseIdentifier: HabitTableViewCell.defaultReuseIdentifier)
    }
    
    //MARK: - Actions
    @objc func addHabitTapped() {
        let vc  = AddHabitViewController()
        vc.delegate = self
        let newNav = UINavigationController(rootViewController: vc)
        self.present(newNav, animated: true, completion: nil)
    }
}

extension HabitsTableViewController: AddHabitViewControllerDelegate{
    func addHabit(_ item: Habit) {
        habitDAO.save()
        habits.append(item)
        let index = IndexPath(row: habits.count-1, section: 0)
        tableView.insertRows(at: [index], with: .automatic)
    }
}

extension HabitsTableViewController: HabitDetailsTableViewControllerDelegate{
    func close(viewController: HabitDetailsTableViewController, item: Habit) {
        let index = habits.firstIndex(of: item)!
        let indexPath = IndexPath(row: index, section: 0)
        viewController.dismiss(animated: true, completion: nil)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
