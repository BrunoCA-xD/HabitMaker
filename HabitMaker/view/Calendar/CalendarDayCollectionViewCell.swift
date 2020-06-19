//
//  CalendarDayCollectionViewCell.swift
//  HabitMaker
//
//  Created by Bruno Cardoso Ambrosio on 25/04/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//

import UIKit

class CalendarDayCollectionViewCell: UICollectionViewCell, Identifiable {
     
    var date: Date?
    let lbl: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.dynamicFont = UIFont.preferredFont(forTextStyle: .body)
        return l
    }()
    let imageViewBadge: UIImageView = {
        
        let imgview = UIImageView()
        imgview.translatesAutoresizingMaskIntoConstraints = false
        imgview.tintColor = .systemIndigo
        imgview.isHidden = true
        return imgview
    }()
    var imageBadgeIcon: UIImage? {
        didSet {
            if imageBadgeIcon != nil {
                imageViewBadge.image = imageBadgeIcon
                imageViewBadge.isHidden = false
            }else {
                imageViewBadge.isHidden = true
            }
        }
    }
    
    func configure(day: Int, components: DateComponents){
        lbl.text = "\(day)"
        date = Calendar.current.date(from: DateComponents(year: components.year, month: components.month,day:day))!
    
        layer.borderWidth = 0
        layer.borderColor = .none
        backgroundColor = .none
    }
    
    private func commonInit() {
        self.clipsToBounds = false
        addSubview(lbl)
        addSubview(imageViewBadge)
        
        lbl.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lbl.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        
        imageViewBadge.widthAnchor.constraint(equalToConstant: 18).isActive = true
        imageViewBadge.heightAnchor.constraint(equalToConstant: 16).isActive = true
        imageViewBadge.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageViewBadge.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
