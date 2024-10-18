//
//  FilterByDateViewModel.swift
//  MyFinanceLabaratory
//
//  Created by Asadbek Yoldoshev on 17/10/24.
//

import SwiftUI

final class FilterByDateViewModel: ObservableObject {
    
    @Published var startDate: Date = Calendar.current.date(byAdding: .month, value: -1, to: Date()) ?? Date()
    @Published var endDate: Date = Date()
    
    
    init() {  }
}
