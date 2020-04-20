//
//  habitsTableViewController.swift
//  HabitMaker
//
//  Created by Bruno Cardoso Ambrosio on 16/04/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//

import UIKit

class HabitsTableViewController: UITableViewController {
    
    
    var habits:[Habit] = [Habit(title: "habit 1")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigation()
        registerCells()
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habits.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HabitTableViewCell.defaultReuseIdentifier, for: indexPath) as? HabitTableViewCell else {
            fatalError("HabitTableViewCell could not load")
        }
        
        cell.titleLabel.text = habits[indexPath.row].title
        
        return cell
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    func setUpNavigation() {
        navigationItem.title = "Habits"
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.2431372549, green: 0.7647058824, blue: 0.8392156863, alpha: 1)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.label]
        
        let addHabitItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addHabitTapped))
        addHabitItem.tintColor = .label
        self.navigationItem.rightBarButtonItems = [addHabitItem]
        
    }
    
    func registerCells() {
        tableView.register(HabitTableViewCell.self, forCellReuseIdentifier: HabitTableViewCell.defaultReuseIdentifier)
    }
    
    
    @objc func addHabitTapped() {
        let vc  = AddHabitViewController()
//        let vc = TestViewController()
        self.present(vc, animated: true, completion: nil)
    }
}
