//
//  HeaderView.swift
//  HabitMaker
//
//  Created by Bruno Cardoso Ambrosio on 18/04/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//

import UIKit

//MARK: - ModalHeader Actions
protocol ModalHeaderActionsDelegate: class {
    func closeButtonTapped()
    func confirmButtonTapped()
}
//Turns the confirmButtonTapped a not required implementation
extension ModalHeaderActionsDelegate {
    func confirmButtonTapped() {}
}

class ModalHeaderView: UIView {

    // MARK: - outlets
    let headerTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.dynamicFont = UIFont.preferredFont(forTextStyle: .title1)
        return label
    }()
    
    let closeButton: UIButton = {
        let b = UIButton(type: .close)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    var confirmButton: UIButton? = nil
    
    weak var delegate: ModalHeaderActionsDelegate?
    
    /// Initializes a header to a modal view, with close button(x)
    /// - Parameter needsConfirmButton: defines if the header will have a confirm button with text "Save"
    init(needsConfirmButton: Bool) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(headerTitle)
        self.addSubview(closeButton)
        
        headerTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        headerTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        closeButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        closeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        
        closeButton.addTarget(self, action: #selector(Self.closeModalTapped), for: .touchDown)
        
        if needsConfirmButton {
            confirmButton = genConfirmButton()
            
            self.addSubview(confirmButton!)
            
            confirmButton!.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            confirmButton!.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
            
            confirmButton!.addTarget(self, action: #selector(Self.confirmButtonTapped), for: .touchDown)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// Used when the initializer parameter is true and the modal need to have a confirm button
    /// - Returns: an UIButton of type .system and title 'save'
    fileprivate func genConfirmButton() -> UIButton {
        let b = UIButton(type: .system)
        b.setTitle("Save", for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.tintColor = .systemBlue
        return b
    }
}

//MARK: - ModalHeader Actions implementation
extension ModalHeaderView {
    @objc private func closeModalTapped() {
        delegate?.closeButtonTapped()
    }
    
    @objc private func confirmButtonTapped() {
        delegate?.confirmButtonTapped()
    }
}
