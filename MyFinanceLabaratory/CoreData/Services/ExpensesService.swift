//
//  ExpensesService.swift
//  MyFinanceLabaratory
//
//  Created by Asadbek Yoldoshev on 15/10/24.
//

import Foundation
import CoreData
import UIKit

class ExpensesService {
    
    static var viewContext: NSManagedObjectContext {
        CoreDataProvider.shared.persistentContainer.viewContext
    }
    
    static func save() throws {
        try viewContext.save()
    }

    static func saveExpenses(_ expenses: Double, _ date: Date, _ category: String, _ name: String) throws {
        let newExpenses = Expenses(context: viewContext)
        newExpenses.id = UUID()
        newExpenses.expenses = expenses
        newExpenses.date = date
        newExpenses.name = name
        newExpenses.category = category
        try save()
    }
    
    static func deleteExpense(_ expense: Expenses) throws {
        viewContext.delete(expense)
        try save()
    }
    
    static func fetchExpenses(for category: String) throws -> [Expenses] {
        let request: NSFetchRequest<Expenses> = Expenses.fetchRequest()
        request.predicate = NSPredicate(format: "category == %@", category)
        return try viewContext.fetch(request)
    }
}
