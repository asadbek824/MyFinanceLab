//
//  AllExpensesView .swift
//  MyFinanceLabaratory
//
//  Created by Asadbek Yoldoshev on 15/10/24.
//

import SwiftUI

struct AllExpensesView: View {
    
    @FetchRequest(
        entity: Expenses.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Expenses.date, ascending: false)]
    ) private var allExpenses: FetchedResults<Expenses>
    
    @EnvironmentObject var salaresViewModel: SalaresViewModel
    
    @State private var contentHeight: CGFloat = 0 
    
    var deleteExpensesAction: (Expenses) -> ()
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 20) {
                
                if allExpenses.isEmpty {
                    Text("Расходы не найдены.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    if contentHeight > geometry.size.height {
                        ScrollView {
                            content
                        }
                    } else {
                        content
                    }
                }
            }
            .navigationTitle("Все расходы")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private var content: some View {
        VStack {
            ForEach(allExpenses, id: \.id) { expense in
                HStack {
                    VStack(alignment: .leading) {
                        Text(expense.name.uppercased())
                            .font(.headline)
                            .foregroundColor(.blue)
                        Text("Категория: \(expense.category)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Text("Сумма: $\(Int(expense.expenses))")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Text("Дата добавления: \(salaresViewModel.formattedDate(expense.date))")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    
                    Button(action: {
                        deleteExpensesAction(expense)
                    }) {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                            .padding()
                    }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 5)
                .padding(.horizontal)
            }
        }
        .background(
            GeometryReader { contentGeometry in
                Color.clear
                    .onAppear {
                        contentHeight = contentGeometry.size.height
                    }
            }
        )
        .padding()
    }
}
