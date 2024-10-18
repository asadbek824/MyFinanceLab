//
//  AddSalaresView.swift
//  MyFinanceLabaratory
//
//  Created by Asadbek Yoldoshev on 15/10/24.
//

import SwiftUI

struct AddSalaresView: View {
    
    @EnvironmentObject var salaresViewModel: SalaresViewModel
    
    var saveButtonAction: () -> ()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Доходы и расходы")
                .font(.largeTitle)
                .bold()
            
            ZStack(alignment: .trailing) {
                TextField("Введите ваш ежемесячный доход", text: $salaresViewModel.incomeText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                
                Button {
                    saveButtonAction()
                } label: {
                    Text("save")
                }
                .padding()
                .alert(isPresented: $salaresViewModel.showAlert) {
                    Alert(
                        title: Text("Ошибка"),
                        message: Text("Пожалуйста, введите доход."),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    AddSalaresView(saveButtonAction: {  })
}
