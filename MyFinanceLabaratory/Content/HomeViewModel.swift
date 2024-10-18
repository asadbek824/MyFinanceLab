//
//  HomeViewModel.swift
//  MyFinanceLabaratory
//
//  Created by Asadbek Yoldoshev on 17/10/24.
//

import SwiftUI

final class HomeViewModel: ObservableObject {
    
    @ObservedObject var salaresViewModel: SalaresViewModel
    @ObservedObject var budjetViewModel: BudgetCategoryViewModel

    init(salaresViewModel: SalaresViewModel, budjetViewModel: BudgetCategoryViewModel) {
        self.salaresViewModel = salaresViewModel
        self.budjetViewModel = budjetViewModel
    }
    
    func addSalaryButtonAction() {
        do {
            try ReminderService.saveOrUpdateIncome(salaresViewModel.getCurrentMonth(), Double(salaresViewModel.incomeText) ?? 0)
        } catch {
            print(error)
        }
    }
    
    func addExpensesButtonAction() {
        do {
            try ExpensesService.saveExpenses(
                Double(salaresViewModel.expensesText) ?? 0,
                salaresViewModel.getCurrentDate(),
                salaresViewModel.selectedCategory,
                salaresViewModel.expensesNameText
            )
            
            let usedExpenses = calculateUsedExpenses(for: salaresViewModel.selectedCategory)
            
            try BudjetService.saveOrUpdateBudget(
                Double(budjetViewModel.limit) ?? 0.0,
                salaresViewModel.selectedCategory,
                usedExpenses
            )
            
        } catch {
            print(error)
        }
    }
    
    func deleteExpensesButtonAction(expense: Expenses) {
        do {
            try ExpensesService.deleteExpense(expense)
        } catch {
            print(error)
        }
    }
    
    func calculateUsedExpenses(for category: String) -> Double {
        let allExpenses = try? ExpensesService.fetchExpenses(for: category)
        return allExpenses?.reduce(0) { $0 + $1.expenses } ?? 0.0
    }
    
    func addBudjetButtonAction() {
        do {
            let usedExpenses = calculateUsedExpenses(for: budjetViewModel.selectedCategory)
            try BudjetService.saveOrUpdateBudget(
                Double(budjetViewModel.limit) ?? 0.0,
                budjetViewModel.selectedCategory,
                usedExpenses
            )
        } catch {
            print(error)
        }
    }
    
    func updateBudjetButtonAction(budjet: Budjet) {
        do {
            budjet.limit = Double(budjetViewModel.limit) ?? 0.0
            let usedExpenses = calculateUsedExpenses(for: budjet.category)
            budjet.used = usedExpenses
            try BudjetService.save()
        } catch {
            print("Ошибка при обновлении бюджета: \(error)")
        }
    }
        
    func deleteBudjetButtonAction(budjet: Budjet) {
        do {
            try BudjetService.deleteBudget(budjet)
            print("Бюджет успешно удалён")
        } catch {
            print("Ошибка при удалении бюджета: \(error)")
        }
    }
}
