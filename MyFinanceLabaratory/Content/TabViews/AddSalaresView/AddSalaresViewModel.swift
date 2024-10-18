//
//  SalaresViewModel.swift
//  MyFinanceLabaratory
//
//  Created by Asadbek Yoldoshev on 15/10/24.
//

import SwiftUI

final class SalaresViewModel: ObservableObject {
    
    @Published var income: [IncomeModel]? = []
    @Published var incomeText: String = ""
    @Published var showAlert: Bool = false
    
    init() {  }
    
    func getCurrentMonth() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        return dateFormatter.string(from: Date())
    }
}
