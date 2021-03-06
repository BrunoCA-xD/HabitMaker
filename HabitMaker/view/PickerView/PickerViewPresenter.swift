//
//  PickerViewPresenter.swift
//  HabitMaker
//
//  Created by Bruno Cardoso Ambrosio on 17/06/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//

import UIKit

protocol PickerViewPresenterDelegate: AnyObject {
    func selected(item: Any)
}

class PickerViewPresenter<T>: UITextField, UIPickerViewDelegate, UIPickerViewDataSource{
    
    //MARK: - Outlets
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
    
    //MARK: Attributes
    var items: [GenericRow<T>]
    var selectedItem: GenericRow<T>?
    weak var pickerDelegate: PickerViewPresenterDelegate?
    
    private func setupView() {
        inputView = pickerView
        inputAccessoryView = doneToolbar
    }

    func showPicker() {
        becomeFirstResponder()
    }
    // MARK: - Actions
    @objc func doneButtonTapped() {
        resignFirstResponder()
    }
    
    // MARK: - UIPickerView dataSource & Delegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        items.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return items[row].showText
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedItem = items[row]
        pickerDelegate?.selected(item: items[row])
    }
    
    // MARK: - Initializers
    init(withItems items: [GenericRow<T>]) {
        self.items = items
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
