//
//  ContentView.swift
//  MyFinanceLabaratory
//
//  Created by Asadbek Yoldoshev on 15/10/24.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var salaresViewModel = SalaresViewModel()
    @StateObject var budgetViewModel = BudgetCategoryViewModel()
    @StateObject var homeViewModel: HomeViewModel
    
    init() {
        let salaresVM = SalaresViewModel()
        let budgetVM = BudgetCategoryViewModel()
        
        _homeViewModel = StateObject(wrappedValue: HomeViewModel(
            salaresViewModel: salaresVM,
            budjetViewModel: budgetVM
        ))
        
        _salaresViewModel = StateObject(wrappedValue: salaresVM)
        _budgetViewModel = StateObject(wrappedValue: budgetVM)
        
        budgetVM.updateCategories(with: salaresVM.categories)
        _budgetViewModel = StateObject(wrappedValue: budgetVM)
    }
    
    var body: some View {
        TabView {
            AddSalaresView {
                homeViewModel.addSalaryButtonAction()
            } addedExpensesAction: {
                homeViewModel.addExpensesButtonAction()
            } deleteExpensesAction: { expense in
                homeViewModel.deleteExpensesButtonAction(expense: expense)
            }
            .environmentObject(salaresViewModel)
            .tabItem {
                Image(systemName: "plus.circle")
                Text("Add Salares")
            }
            
            BudgetCategoryView(
                okButtonAction: {
                    homeViewModel.addBudjetButtonAction()
                },
                updateBudgeteAction: { budget in 
                    homeViewModel.updateBudjetButtonAction(budjet: budget)
                },
                deleteBudgeteAction: { budget in
                    homeViewModel.deleteBudjetButtonAction(budjet: budget)
                }
            )
                .environmentObject(budgetViewModel)
                .tabItem {
                    Image(systemName: "dollarsign.circle")
                    Text("Планирование бюджета")
                }
            
            //            FilterByDateView()
            //                .environmentObject(filterByDateViewModel)
            //                .tabItem {
            //                    Image(systemName: "calendar")
            //                    Text("Фильтр по дате")
            //                }
        }
    }
}
