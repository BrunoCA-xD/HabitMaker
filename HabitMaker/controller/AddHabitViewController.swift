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
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
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
        
    }
    
    @objc private func closeModalTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func confirmButtonTapped() {
        print("Salvar")
    }
}

extension AddHabitViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 1:
            let cell = SwitchTableViewCell()
            cell.imageView?.image = UIImage(systemName: "bell.fill")
            cell.label.text = "Set reminder"
            cell.onSwitch.isOn = true
            return cell
        case 0:
            let cell = FormFieldTableViewCell()
            cell.label.text = "Title"
            cell.value.placeholder = "Habit title"
            return cell
        default:
            let cell = SwitchTableViewCell()
            cell.label.text = "Habit default"
            return cell
        }
    }
}

