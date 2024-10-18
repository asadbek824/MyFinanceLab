//
//  GraphicalAnalysisView.swift
//  MyFinanceLabaratory
//
//  Created by Asadbek Yoldoshev on 15/10/24.
//

import SwiftUI
import Charts

struct FinancialData: Identifiable {
    let id = UUID()
    let type: String
    let amount: Double
}

struct GraphicalAnalysisView: View {
    var income: Double
    var expenses: Double
    var categories: [String: Double]
    
    @State private var animatedIncome: Double = 0
    @State private var animatedExpenses: Double = 0
    @State private var selectedMonth: String
    
    let months = ["Январь", "Февраль", "Март", "Апрель", "Май", "Июнь", "Июль", "Август", "Сентябрь", "Октябрь", "Ноябрь", "Декабрь"]
    
    init(income: Double, expenses: Double, categories: [String: Double]) {
        self.income = income
        self.expenses = expenses
        self.categories = categories
        
        // Получаем текущий месяц
        let currentMonthIndex = Calendar.current.component(.month, from: Date()) - 1
        _selectedMonth = State(initialValue: months[currentMonthIndex])
    }
    
    var data: [FinancialData] {
        return [
            FinancialData(type: "Доходы", amount: animatedIncome),
            FinancialData(type: "Расходы", amount: animatedExpenses)
        ]
    }
    
    var categoryData: [FinancialData] {
        categories.map { FinancialData(type: $0.key, amount: $0.value) }
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {

                Picker("Месяц", selection: $selectedMonth) {
                    ForEach(months, id: \.self) { month in
                        Text(month).tag(month)
                    }
                }
                .pickerStyle(DefaultPickerStyle())
                .padding()
                
                Chart {
                    ForEach(data) { entry in
                        BarMark(
                            x: .value("Тип", entry.type),
                            y: .value("Сумма", entry.amount)
                        )
                        .foregroundStyle(by: .value("Тип", entry.type))
                    }
                }
                .onAppear {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        animatedIncome = income
                        animatedExpenses = expenses
                    }
                }
                .frame(height: 300)
                .padding()
                
                Chart {
                    ForEach(categoryData) { entry in
                        BarMark(
                            x: .value("Категория", entry.type),
                            y: .value("Сумма", entry.amount)
                        )
                        .foregroundStyle(by: .value("Категория", entry.type))
                    }
                }
                .frame(height: 300)
                .padding()
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Анализ расходов и доходов")
        .navigationBarTitleDisplayMode(.inline)
    }
}
