//
//  StepperTableViewCell.swift
//  HabitMaker
//
//  Created by Bruno Cardoso Ambrosio on 22/05/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//

import UIKit

public class StepperTableViewCell: UITableViewCell {
    
    let label: UITextField!
    let stepper: UIStepper!
    private let imgView: UIImageView!
    private let padding: CGFloat = 30.0
    var icon: UIImage! = nil {
        didSet {
            imgView.image = icon
            updateConstraints()
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        label = UITextField()
        stepper = UIStepper()
        imgView = UIImageView()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        label = UITextField()
        stepper = UIStepper()
        imgView = UIImageView()
        
        super.init(coder: coder)
        
        commonInit()
    }
    
    fileprivate func setConstraints() {
        imgView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        stepper.translatesAutoresizingMaskIntoConstraints = false
        
        imgView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        imgView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        imgView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imgView.setContentHuggingPriority(.init(251), for: .horizontal)
        
        label.setContentHuggingPriority(.init(251), for: .horizontal)
        label.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: 10).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: stepper.leadingAnchor, constant: -padding).isActive = true
        
        stepper.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stepper.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding).isActive = true
    }
    
    func commonInit() {
        selectionStyle = .none
        
        addSubview(imgView)
        addSubview(label)
        addSubview(stepper)
        
        setConstraints()
        label.delegate = self
        label.keyboardType = .decimalPad
        label.returnKeyType = .done
        label.text = "\(stepper.value)"
        label.enablesReturnKeyAutomatically = true
        label.addTarget(self, action: #selector(Self.textChanged), for: .allEditingEvents)
        stepper.addTarget(self, action: #selector(Self.stepperChanged), for: .valueChanged)
        
    }
    
    @objc private func textChanged() {
        print("valueChanged")
        var text = label.text ?? "0.0"
        let decimalSeparator = Locale.current.decimalSeparator ?? "."
        text = text.replacingOccurrences(of: decimalSeparator, with: ".")
        let number = Double(text) ?? 0.0
        stepper.value = number
    }
    
    @objc private func stepperChanged() {
        let decimalSeparator = Locale.current.decimalSeparator ?? "."
        label.text = "\(stepper.value)".replacingOccurrences(of: ".", with: decimalSeparator)
    }
    
}
extension StepperTableViewCell: UITextFieldDelegate  {
    
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
