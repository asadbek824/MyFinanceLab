//
//  SalaresViewModel.swift
//  MyFinanceLabaratory
//
//  Created by Asadbek Yoldoshev on 15/10/24.
//

import SwiftUI

final class SalaresViewModel: ObservableObject {
    
    @Published var showAlert: Bool = false
    @Published var isEditing: Bool = false
    
    //Income
    @Published var incomeText: String = ""
    
    //Expenses
    @Published var expensesText: String = ""
    @Published var selectedCategory: String = "Еда"
    @Published var categories = ["Еда", "Транспорт", "Развлечения", "Здоровье", "Покупки", "Другое"]
    @Published var expensesNameText: String = ""
    
    @Published var showAddCategorySheet: Bool = false
    @Published var newCategoryText: String = ""
    
    init() {
        loadCategories()
    }
    
    private func loadCategories() {
        if let savedCategories = UserDefaults.standard.array(forKey: "categories") as? [String] {
            categories = savedCategories
        } else {
            categories = ["Еда", "Транспорт", "Развлечения", "Здоровье", "Покупки", "Другое"]
        }
    }
        
    private func saveCategories() {
        UserDefaults.standard.set(categories, forKey: "categories")
    }
        
    func addCategory() {
        if !newCategoryText.isEmpty {
            categories.append(newCategoryText)
            selectedCategory = newCategoryText
            newCategoryText = ""
            saveCategories()
        }
    }
    
    func getCurrentMonth() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL, YYYY"
        return dateFormatter.string(from: Date())
    }
    
    func getCurrentDate() -> Date {
        let currentDate = Date()
        let calendar = Calendar.current
        
        let seconds = calendar.component(.second, from: currentDate)
        let minutes = calendar.component(.minute, from: currentDate)
        let hours = calendar.component(.hour, from: currentDate)
        let day = calendar.component(.day, from: currentDate)
        let month = calendar.component(.month, from: currentDate)
        let year = calendar.component(.year, from: currentDate)
        
        print("Текущая дата: \(day)-\(month)-\(year)")
        print("Текущее время: \(hours):\(minutes):\(seconds)")
        
        return currentDate
    }
    
    func formattedDate(_ date: Date?) -> String {
        guard let date = date else { return "Не указана" }
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "d MMMM yyyy, HH:mm"
        
        return dateFormatter.string(from: date)
    }
    
    func clearAll() {
        expensesText = ""
        selectedCategory = "Еда"
        expensesNameText = ""
    }
}
