//
//  AddSalaresView.swift
//  MyFinanceLabaratory
//
//  Created by Asadbek Yoldoshev on 15/10/24.
//

import SwiftUI

struct AddSalaresView: View {
    
    @FetchRequest(
        entity: Income.entity(),
        sortDescriptors: []
    ) private var salares: FetchedResults<Income>
    
    @FetchRequest(
        entity: Expenses.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Expenses.date, ascending: false)]
    ) private var expenses: FetchedResults<Expenses>
    
    @EnvironmentObject var salaresViewModel: SalaresViewModel
    
    @State private var currentIndex: Int = 0
    private let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    
    @State private var showExpenses = true
    @State private var navigateToSalares = false
    @State private var navigateToGraph = false
    
    var saveButtonAction: () -> ()
    var addedExpensesAction: () -> ()
    var deleteExpensesAction: (Expenses) -> ()
    
    private var totalIncome: Double {
        return salares.last?.income ?? 0
    }
    
    private var totalExpenses: Double {
        return expenses.reduce(0) { $0 + $1.expenses }
    }
    
    private var profit: Double {
        return totalIncome - totalExpenses
    }
    
    private var categoriesAndExpenses: [String: Double] {
        var categoryDict: [String: Double] = [:]
        
        for expense in expenses {
            categoryDict[expense.category, default: 0] += expense.expenses
        }
        
        return categoryDict
    }
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    
                    addSalareView()
                    
                    addExpensesView()
                    
                    listExpensesView()
                    
                }
            }
            .scrollDisabled(true)
            .padding()
            .navigationTitle("Доходы и расходы")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button(action: {
                    navigateToGraph = true
                }) {
                    Image(systemName: "chart.bar.fill")
                },
                trailing: NavigationLink(destination: SalaresView(), isActive: $navigateToSalares) {
                    Button(action: {
                        navigateToSalares = true
                    }) {
                        Image(systemName: "list.bullet")
                    }
                }
            )
            .background(
                NavigationLink(
                    destination: GraphicalAnalysisView(income: totalIncome, expenses: totalExpenses, categories: categoriesAndExpenses), isActive: $navigateToGraph) { EmptyView() }
            )
            .onReceive(timer) { _ in
                if expenses.count > 1 {
                    withAnimation(.easeInOut(duration: 1.0)) {
                        showExpenses = false
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        currentIndex = (currentIndex + 1) % expenses.count
                        withAnimation(.easeInOut(duration: 1.0)) {
                            showExpenses = true
                        }
                    }
                }
            }
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
    }
}

extension AddSalaresView {
    
    @ViewBuilder
    func addSalareView() -> some View {
        if salares.isEmpty || salaresViewModel.isEditing {
            VStack(alignment: .leading) {
                TextField("Введите ваш ежемесячный доход", text: $salaresViewModel.incomeText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                
                Button(action: {
                    if !salaresViewModel.incomeText.isEmpty {
                        saveButtonAction()
                        withAnimation(.easeInOut(duration: 0.3)) {
                            salaresViewModel.isEditing = false
                        }
                    } else {
                        salaresViewModel.showAlert = true
                    }
                }) {
                    Text("Сохранить")
                        .frame(maxWidth: .infinity)
                        .frame(height: 44)
                        .background(.black)
                        .foregroundColor(.white)
                        .cornerRadius(22)
                }
                .alert(isPresented: $salaresViewModel.showAlert) {
                    Alert(
                        title: Text("Ошибка"),
                        message: Text("Пожалуйста, введите доход."),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
        } else {
            HStack {
                Text("Ваш ежемесячный доход: \(Int(salares.last?.income ?? 0))$")
                    .font(.headline)
                
                Spacer()
                
                Image(systemName: "pencil.circle.fill")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.blue)
                    .onTapGesture {
                        if let lastIncome = salares.last {
                            salaresViewModel.incomeText = String(Int(lastIncome.income))
                        }
                        withAnimation(.easeInOut(duration: 0.3)) {
                            salaresViewModel.isEditing = true
                        }
                    }
            }
        }
    }
    
    @ViewBuilder
    func addExpensesView() -> some View {
        VStack(alignment: .leading) {
            
            TextField("Введите сумму расхода", text: $salaresViewModel.expensesText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
            
            TextField("Введите название расхода", text: $salaresViewModel.expensesNameText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.default)
            
            HStack(spacing: .zero) {
                Text("Выберите категорию трат:")
                    .font(.headline)
                
                Spacer()
                
                Picker("Выберите категорию", selection: $salaresViewModel.selectedCategory) {
                    ForEach(salaresViewModel.categories, id: \.self) { category in
                        Text(category)
                    }
                    
                    Text("Добавить категорию")
                        .tag("Добавить категорию")
                }
                .pickerStyle(MenuPickerStyle())
                .onChange(of: salaresViewModel.selectedCategory) { newValue in
                    if newValue == "Добавить категорию" {
                        salaresViewModel.showAddCategorySheet = true
                    }
                }
                .padding(.vertical)
            }
            
            Button(action: {
                if !salaresViewModel.expensesText.isEmpty {
                    addedExpensesAction()
                    salaresViewModel.clearAll()
                } else {
                    salaresViewModel.showAlert = true
                }
            }) {
                Text("Сохранить")
                    .frame(maxWidth: .infinity)
                    .frame(height: 44)
                    .background(.black)
                    .foregroundColor(.white)
                    .cornerRadius(22)
            }
            .alert(isPresented: $salaresViewModel.showAlert) {
                Alert(
                    title: Text("Ошибка"),
                    message: Text("Пожалуйста, введите ваш расход."),
                    dismissButton: .default(Text("OK"))
                )
            }
            .sheet(isPresented: $salaresViewModel.showAddCategorySheet, onDismiss: {
                salaresViewModel.selectedCategory = "Еда"
            }) {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Добавить новую категорию".uppercased())
                        .font(.headline)

                    TextField("Введите название категории", text: $salaresViewModel.newCategoryText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    HStack {
                        Button("Отмена") {
                            salaresViewModel.selectedCategory = "Еда"
                            salaresViewModel.newCategoryText = ""
                            salaresViewModel.showAddCategorySheet = false
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .frame(height: 44)
                        .background(.gray)
                        .foregroundColor(.white)
                        .cornerRadius(22)
                        
                        Spacer()
                        
                        Button("Добавить") {
                            salaresViewModel.addCategory()
                            salaresViewModel.showAddCategorySheet = false
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .frame(height: 44)
                        .background(.black)
                        .foregroundColor(.white)
                        .cornerRadius(22)
                    }
                }
                .padding()
                .presentationDetents([.medium, .fraction(0.3)])
            }
        }
    }
    
    @ViewBuilder
    func listExpensesView() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Ваши расходы")
                    .font(.headline)
                    .padding(.top, 20)
                
                Spacer()
                
                NavigationLink(
                    destination:
                        AllExpensesView(deleteExpensesAction: { expense in
                            deleteExpensesAction(expense)
                        })
                        .environmentObject(salaresViewModel)
                ) {
                    Text("Все")
                        .font(.headline)
                        .padding(.top, 20)
                }
            }
            
            if expenses.isEmpty {
                Text("Расходы пока не добавлены.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.top, 10)
            } else {
                let expensesToShow = Array(expenses[currentIndex..<min(currentIndex + 1, expenses.count)])
                
                if showExpenses {
                    ForEach(expensesToShow, id: \.id) { expense in
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
                                Text("Дата: \(salaresViewModel.formattedDate(expense.date))")
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
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white)
                                .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 5)
                        )
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
}

#Preview {
    AddSalaresView(saveButtonAction: {  }, addedExpensesAction: {  }, deleteExpensesAction: { _ in  })
}
