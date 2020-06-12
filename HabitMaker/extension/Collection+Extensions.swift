//
//  Collection+Extensions.swift
//  HabitMaker
//
//  Created by Bruno Cardoso Ambrosio on 11/06/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//

import Foundation
extension Collection where Element == Completion {
    
    /// As the Completions are ordered by its dates, it returns a collections of collections with all the dates consecutives
    func splitConsecutive() -> [Array<Completion>] {
        guard let first = self.first else {return []}
        var result = [[first]]
        var i = 0
        for element in self.dropFirst() {
            if element.isConsecutive(of: result[i].last!) {
                result[i].append(element)
            }else {
                result.append([element])
                i+=1
            }
        }
        return result
    }
}
