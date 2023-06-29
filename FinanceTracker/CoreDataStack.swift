//
//  CoreDataStack.swift
//  FinanceTracker
//
//  Created by Danny on 28.06.2023.
//

import Foundation
import CoreData

class CoreDataStack {
    
    // shared property pattern
    // let us access the CoreDataStack from anywhere in the app
    static let shared = CoreDataStack()
    
    // setup a persistent container
    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FinanceTracker")
        
        // creates a persistent store
        container.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Failed to load persistent stores: \(error)")
            }
        }

        return container
    }()
    
    
    // create easy access to the ManagedObjectContext
    // using a computed property
    var mainContext: NSManagedObjectContext {
        return container.viewContext
    }
}
