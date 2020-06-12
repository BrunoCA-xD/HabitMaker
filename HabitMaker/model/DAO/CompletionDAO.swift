//
//  CompletionDAO.swift
//  HabitMaker
//
//  Created by Bruno Cardoso Ambrosio on 29/05/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//

import Foundation

class CompletionDAO {
    private let context = CoreDataDAO.shared.persistentContainer.viewContext
    
    /// List all the completions in the database
    /// - Returns: a list with all completions in database
    func listAll() -> [Completion] {
        var completions: [Completion] = []
        
        do {
            completions = try context.fetch(Completion.fetchRequest())
        }catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return completions
    }
    
    /// Calls the generic method to delete an item
    /// - Parameter item: item to be deleted
    func delete(completion: Completion) {
        context.delete(completion)
    }
    
    /// Generates a new completion to a given habit,  using its entity and the context
    /// - Parameter habit: the habit that the completion will be related
    /// - Returns: a new completion to be used
    func genNew(withHabit habit: Habit) -> Completion {
        let completion = Completion(entity: Completion.entity(), insertInto: context)
        completion.habit = habit
        
        return completion
    }
    
    
}
