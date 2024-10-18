//
//  BudgetCategoryViewModel.swift
//  MyFinanceLabaratory
//
//  Created by Asadbek Yoldoshev on 18/10/24.
//

import SwiftUI

final class BudgetCategoryViewModel: ObservableObject {
    
    @Published var selectedCategory: String = "Еда"
    @Published var categories: [String] = []
    @Published var limit: String = ""
    
    init() {  }
    
    func updateCategories(with categories: [String]) {
        self.categories = categories
    }
    
    func clearAll() {
        selectedCategory = "Еда"
        limit = ""
    }
}
