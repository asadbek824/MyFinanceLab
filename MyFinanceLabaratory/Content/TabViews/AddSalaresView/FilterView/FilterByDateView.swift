//
//  FilterView.swift
//  MyFinanceLabaratory
//
//  Created by Asadbek Yoldoshev on 17/10/24.
//

import SwiftUI

struct FilterByDateView: View {
    
    @EnvironmentObject var vm: FilterByDateViewModel

    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                content()
            }
            .navigationTitle("Фильтр")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

//View Bulder
extension FilterByDateView {
    
    @ViewBuilder
    func content() -> some View {
        VStack {
            
            DatePicker("Начальная дата", selection: $vm.startDate, displayedComponents: .date)
            
            DatePicker("Конечная дата", selection: $vm.endDate, displayedComponents: .date)
            
            Button(action: {
                applyDateFilter()
            }) {
                Text("Применить фильтр")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            Spacer()
        }
        .padding()
    }
}

//Actions
extension FilterByDateView {
    
    func applyDateFilter() {
        
    }
}
