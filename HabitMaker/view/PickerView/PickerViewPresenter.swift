//
//  PickerViewPresenter.swift
//  HabitMaker
//
//  Created by Bruno Cardoso Ambrosio on 12/05/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//

import UIKit

//TODO: I wish it was more decoupled, like it was one component that i could put on a pod
class PickerViewPresenter: UITextField, UIPickerViewDataSource, UIPickerViewDelegate {
    
    private lazy var doneToolbar: UIToolbar = {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))

        let items = [flexSpace, doneButton]
        toolbar.items = items
        toolbar.sizeToFit()

        return toolbar
    }()

    private lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        return pickerView
    }()
    
    // This makes this PickerView coupled to GoalCriterion
    var items: [GoalCriterion] = GoalCriterion.allCases
    var didSelectItem: ((GoalCriterion) -> Void)?

    var selectedItem: GoalCriterion!

    init() {
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        inputView = pickerView
        inputAccessoryView = doneToolbar
    }

    func showPicker() {
        becomeFirstResponder()
    }
    // MARK: - Actions
    @objc func doneButtonTapped() {
        if let selectedItem = selectedItem {
            didSelectItem?(selectedItem)
        }
        resignFirstResponder()
    }
    
    // MARK: - UIPickerVie dataSource & Delegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return items[row].showValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedItem = items[row]
    }
}
