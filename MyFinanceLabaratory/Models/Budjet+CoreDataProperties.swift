//
//  Budjet+CoreDataProperties.swift
//  MyFinanceLabaratory
//
//  Created by Asadbek Yoldoshev on 17/10/24.
//

import Foundation
import CoreData
import UIKit

extension Budjet {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Budjet> {
        return NSFetchRequest<Budjet>(entityName: "Budjet")
    }
    
    @NSManaged public var id: UUID
    @NSManaged public var category: String
    @NSManaged public var limit: Double
    @NSManaged public var used: Double
}

extension Budjet: Identifiable {
    
}

extension Budjet {
    
}
