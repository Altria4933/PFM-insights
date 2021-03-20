//
//  Persistence.swift
//  PFM insights
//
//  Created by Shane Xu on 17/03/21.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "TransactionList")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? { fatalError("Unresolved error: \(error)")
                
            }
    }
    
}
}


