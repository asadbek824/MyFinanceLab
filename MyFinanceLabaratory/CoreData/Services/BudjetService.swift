//
//  BudjetService.swift
//  MyFinanceLabaratory
//
//  Created by Asadbek Yoldoshev on 18/10/24.
//

import Foundation
import CoreData
import UIKit

class BudjetService {
    
    static var viewContext: NSManagedObjectContext {
        CoreDataProvider.shared.persistentContainer.viewContext
    }
    
    static func save() throws {
        try viewContext.save()
    }

    static func saveOrUpdateBudget(_ limit: Double, _ category: String, _ used: Double) throws {
        // Check if a budget for the category already exists
        let fetchRequest: NSFetchRequest<Budjet> = Budjet.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "category == %@", category)
        
        let results = try viewContext.fetch(fetchRequest)
        
        if let existingBudget = results.first {
            // Update the existing budget
            existingBudget.limit = limit
            existingBudget.used = used
        } else {
            // Create a new budget entry
            let newBudjet = Budjet(context: viewContext)
            newBudjet.id = UUID()
            newBudjet.limit = limit
            newBudjet.category = category
            newBudjet.used = used
        }
        
        try save()
    }
    
    static func deleteBudget(_ budjet: Budjet) throws {
        viewContext.delete(budjet)
        try save()
    }
}

