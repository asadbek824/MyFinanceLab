//
//  CustomAlertView.swift
//  MyFinanceLabaratory
//
//  Created by Asadbek Yoldoshev on 18/10/24.
//

import SwiftUI

struct CustomAlertView: View {
    @Binding var showAlert: Bool
    @Binding var selectedCategory: String
    @Binding var categories: [String]
    @Binding var limit: String
    
    var okButtonPressed: () -> ()
    
    var body: some View {
        if showAlert {
            VStack(spacing: 16) {
                Text("Выберите категорию")
                    .font(.headline)
                    .padding(.top)
                
                Picker("", selection: $selectedCategory) {
                    ForEach(categories, id: \.self) { category in
                        Text(category)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .padding(.vertical)
                
                TextField("Введите ваш лимит", text: $limit)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                    .padding()

                HStack {
                    Button("Cancel") {
                        showAlert = false
                    }
                    .alertButtonStyle()

                    Button("OK") {
                        if validateLimit() {
                            okButtonPressed()
                            showAlert = false
                        }
                    }
                    .alertButtonStyle(isPrimary: true)
                }
                .padding(.horizontal)
            }
            .frame(maxWidth: 300)
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(radius: 20)
            .padding()
            .transition(.scale) // Adds a transition effect when showing/hiding
        }
    }
    
    // Validation logic for the limit input
    private func validateLimit() -> Bool {
        guard !limit.isEmpty else {
            print("Limit is empty")
            return false
        }
        return true
    }
}
