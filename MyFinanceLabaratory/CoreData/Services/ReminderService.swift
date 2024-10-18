//
//  ReminderService.swift
//  MyFinanceLabaratory
//
//  Created by Asadbek Yoldoshev on 15/10/24.
//

import Foundation
import CoreData
import UIKit

class ReminderService {
    
    static var viewContext: NSManagedObjectContext {
        CoreDataProvider.shared.persistentContainer.viewContext
    }
    
    static func save() throws {
        try viewContext.save()
    }

    static func saveOrUpdateIncome(_ month: String, _ income: Double) throws {
        let fetchRequest: NSFetchRequest<Income> = Income.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "month == %@", month)

        let results = try viewContext.fetch(fetchRequest)

        if let existingIncome = results.first {
            existingIncome.income = income
        } else {
            let newIncome = Income(context: viewContext)
            newIncome.id = UUID()
            newIncome.income = income
            newIncome.month = month
            newIncome.color = UIColor.black
        }

        try save()
    }
    
    static func deleteAllIncomes() throws {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Income.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        try viewContext.execute(deleteRequest)
        try save()
    }
}
