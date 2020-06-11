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
       
       func listAll() -> [Completion] {
           var completions: [Completion] = []
           
           do {
               completions = try context.fetch(Completion.fetchRequest())
           }catch let error as NSError {
               print("Could not fetch. \(error), \(error.userInfo)")
           }
           
           return completions
       }
    
    func delete(completion: Completion) {
        context.delete(completion)
    }
    
    func genNew(withHabit habit: Habit) -> Completion {
        let completion = Completion(entity: Completion.entity(), insertInto: context)
        completion.habit = habit
        
        return completion
    }
    
    
}
