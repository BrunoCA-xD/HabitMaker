//
//  HabitTypeSelectorTableViewController.swift
//  HabitMaker
//
//  Created by Bruno Cardoso Ambrosio on 04/05/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//

import UIKit

protocol HabitTypeSelectorActions: class {
    func didSelect(type: CompletionType)
}

class HabitTypeSelectorTableViewController: UITableViewController {
    
    var selected: CompletionType!
    let completionTypes = CompletionType.allCases
    weak var delegate: HabitTypeSelectorActions?
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return completionTypes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = completionTypes[indexPath.row].description
        if selected == completionTypes[indexPath.row] {
            cell.accessoryType = .checkmark
        }else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let group = DispatchGroup()
        group.enter()
        
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.delegate?.didSelect( type: self.completionTypes[indexPath.row])
        }
    }

}
