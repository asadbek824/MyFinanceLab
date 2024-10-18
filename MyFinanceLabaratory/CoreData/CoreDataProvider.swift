//
//  CoreDataProvider.swift
//  MyFinanceLabaratory
//
//  Created by Asadbek Yoldoshev on 15/10/24.
//

import CoreData
import Foundation

class CoreDataProvider {
    
    static let shared = CoreDataProvider()
    let persistentContainer: NSPersistentContainer
    
    private init() {
        
        // register transformers
        ValueTransformer.setValueTransformer(UIColorTransformer(), forName: NSValueTransformerName("UIColorTransformer"))
        
        persistentContainer = NSPersistentContainer(name: "IncomeModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error {
                fatalError("Error initializing RemindersModel \(error)")
            }
        }
    }
}
