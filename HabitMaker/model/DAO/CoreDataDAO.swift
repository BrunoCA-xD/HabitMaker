//
//  CoreData.swift
//  HabitMaker
//
//  Created by Bruno Cardoso Ambrosio on 23/04/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//

import Foundation
import CoreData

class CoreDataDAO {
    
    
    /// The shared CoreDataDAO for process
    static let shared = CoreDataDAO()
    
    private init() {}
    
    /// The coredata container where the app is persisting
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "HabitMaker")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error) \(error.userInfo)")
            }
        }
        
        return container
    }()
    
    /// Generic method to save the context
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let error = error as NSError
                fatalError("Unresolved error \(error) \(error.userInfo)")
            }
        }
    }
    
    /// Generic method to delete a NSManagedObject
    /// - Parameter item: an item to be removed
    func delete(item: NSManagedObject) {
        persistentContainer.viewContext.delete(item)
        saveContext()
    }
}
