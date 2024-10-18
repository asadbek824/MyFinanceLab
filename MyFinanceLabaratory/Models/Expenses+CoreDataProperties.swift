//
//  Expenses+CoreDataProperties.swift
//  MyFinanceLabaratory
//
//  Created by Asadbek Yoldoshev on 15/10/24.
//

import Foundation
import CoreData
import UIKit

extension Expenses {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Expenses> {
        return NSFetchRequest<Expenses>(entityName: "Expenses")
    }
    
    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var expenses: Double
    @NSManaged public var category: String
    @NSManaged public var date: Date
}

extension Expenses: Identifiable {
    
}

extension Expenses {
    
}

