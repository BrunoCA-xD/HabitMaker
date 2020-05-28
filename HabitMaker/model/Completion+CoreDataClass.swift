//
//  Completion+CoreDataClass.swift
//  HabitMaker
//
//  Created by Bruno Cardoso Ambrosio on 02/05/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Completion)
public class Completion: NSManagedObject {

    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.achievedNumber = 0.0
        self.isAchived = false
    }
}
