//
//  StepperTableViewCell.swift
//  HabitMaker
//
//  Created by Bruno Cardoso Ambrosio on 22/05/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//

import UIKit

public class StepperTableViewCell: UITableViewCell {
    
    let value: UITextField!
    let stepper: UIStepper!
    private let padding: CGFloat = 30.0
    private let imgView: UIImageView!
    // when the icon changes it updates the imgView
    var icon: UIImage! = nil {
        didSet {
            imgView.image = icon
            updateConstraints()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        value = UITextField()
        stepper = UIStepper()
        imgView = UIImageView()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        value = UITextField()
        stepper = UIStepper()
        imgView = UIImageView()
        
        super.init(coder: coder)
        
        commonInit()
    }
    
    fileprivate func setConstraints() {
        imgView.translatesAutoresizingMaskIntoConstraints = false
        value.translatesAutoresizingMaskIntoConstraints = false
        stepper.translatesAutoresizingMaskIntoConstraints = false
        
        imgView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        imgView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        imgView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imgView.setContentHuggingPriority(.init(251), for: .horizontal)
        
        value.setContentHuggingPriority(.init(251), for: .horizontal)
        value.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: 10).isActive = true
        value.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        value.trailingAnchor.constraint(equalTo: stepper.leadingAnchor, constant: -padding).isActive = true
        
        stepper.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stepper.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding).isActive = true
    }
    
    func commonInit() {
        selectionStyle = .none
        
        addSubview(imgView)
        addSubview(value)
        addSubview(stepper)
        
        setConstraints()
        value.delegate = self
        value.keyboardType = .decimalPad
        value.returnKeyType = .done
        value.text = "\(stepper.value)"
        value.enablesReturnKeyAutomatically = true
        value.addTarget(self, action: #selector(Self.textChanged), for: .allEditingEvents)
        stepper.addTarget(self, action: #selector(Self.stepperChanged), for: .valueChanged)
        
    }
    
    /// The stepper can be updated by the value textField
    @objc private func textChanged() {
        var text = value.text ?? "0.0"
        let decimalSeparator = Locale.current.decimalSeparator ?? "."
        text = text.replacingOccurrences(of: decimalSeparator, with: ".")
        let number = Double(text) ?? 0.0
        stepper.value = number
    }
    
    /// When the stepper value changes, it updates the value textField
    @objc private func stepperChanged() {
        let decimalSeparator = Locale.current.decimalSeparator ?? "."
        value.text = "\(stepper.value)".replacingOccurrences(of: ".", with: decimalSeparator)
    }
    
    func toggleStepperEnabled() {
        stepper.isEnabled = !stepper.isEnabled
    }
    
}

extension StepperTableViewCell: UITextFieldDelegate  {
    
    /// Limits the grouping separator to one in the textField and dont allow it to be the first character
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let decimalSeparator = Locale.current.decimalSeparator ?? "."
        
        let text  = textField.text ?? ""
        let countdots = text.components(separatedBy: decimalSeparator).count - 1
        
        if countdots > 0 && string == decimalSeparator {
            return false
        }
        if text.count == 0 && string == decimalSeparator {
            return false
        }
        return true
    }
    
}
