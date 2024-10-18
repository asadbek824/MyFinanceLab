//
//  Income+CoreDataProperties.swift
//  MyFinanceLabaratory
//
//  Created by Asadbek Yoldoshev on 15/10/24.
//

import Foundation
import CoreData
import UIKit

extension Income {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Income> {
        return NSFetchRequest<Income>(entityName: "Income")
    }
    
    @NSManaged public var id: UUID
    @NSManaged public var month: String
    @NSManaged public var income: Double
    @NSManaged public var color: UIColor?
}

extension Income: Identifiable {
    
}

extension Income {
    
}
