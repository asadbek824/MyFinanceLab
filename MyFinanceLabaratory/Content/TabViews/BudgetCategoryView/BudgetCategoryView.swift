//
//  BudgetCategoryView.swift
//  MyFinanceLabaratory
//
//  Created by Asadbek Yoldoshev on 17/10/24.
//

import SwiftUI

struct BudgetCategoryView: View {
    
    @FetchRequest(
        entity: Budjet.entity(),
        sortDescriptors: []
    ) private var budjet: FetchedResults<Budjet>
    
    @EnvironmentObject var vm: BudgetCategoryViewModel
    
    @State var updateButtonTapped: Bool = false
    
    var okButtonAction: () -> ()
    var updateBudgeteAction: (Budjet) -> ()
    var deleteBudgeteAction: (Budjet) -> ()

    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 10) {
                    
                    addLimitView()
                    
                    content()
                }
                .padding()
            }
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            .navigationTitle("Планирование бюджета")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

extension BudgetCategoryView {
    
    @ViewBuilder
    func addLimitView() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Выберите категорию")
                    .font(.headline)
                
                Spacer()
                
                Picker("", selection: $vm.selectedCategory) {
                    ForEach(vm.categories, id: \.self) { category in
                        Text(category)
                    }
                }
                .pickerStyle(MenuPickerStyle())
            }
            
            TextField("Введите ваш лимит", text: $vm.limit)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
                .padding()
            
            Button {
                okButtonAction()
                vm.limit = ""
                vm.selectedCategory = "Еда"
            } label: {
                Text("Добавить")
                    .frame(maxWidth: .infinity)
                    .frame(height: 44)
                    .background(.black)
                    .foregroundColor(.white)
                    .cornerRadius(22)
            }
        }
    }
    
    @ViewBuilder
    func content() -> some View {
        ForEach(budjet, id: \.id) { budjet in
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 16) {
                    CircularProgressView(progress: budjet.used / budjet.limit)
                        .frame(width: 50, height: 50)
                    
                    VStack(alignment: .leading) {
                        Text(budjet.category)
                            .font(.headline)
                        
                        Text("Лимит: \(budjet.limit.description)")
                            .font(.subheadline)
                        
                        Text("Потраченный: \(budjet.used.description)")
                            .font(.subheadline)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Button {
                            vm.limit = String(budjet.limit)
                            vm.selectedCategory = budjet.category
                            updateBudgeteAction(budjet)
                        } label: {
                            Image(systemName: "pencil")
                        }
                        
                        Spacer()
                        
                        Button {
                            deleteBudgeteAction(budjet)
                        } label: {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10)
            .shadow(radius: 5)
            .padding(.horizontal)
        }
    }
}


extension BudgetCategoryView {
    
    
}


