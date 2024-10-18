//
//  SalaresView.swift
//  MyFinanceLabaratory
//
//  Created by Asadbek Yoldoshev on 15/10/24.
//

import SwiftUI

struct SalaresView: View {
    
    @FetchRequest(sortDescriptors: [])
    private var salares: FetchedResults<Income>
    
    @State private var contentHeight: CGFloat = 0
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    if salares.isEmpty {
                        Text("Доходы пока не добавлены.")
                            .font(.headline)
                            .foregroundColor(.gray)
                            .padding(.top, 50)
                    } else {
                        if contentHeight > geometry.size.height {
                            ScrollView {
                                content
                            }
                        } else {
                            content
                        }
                    }
                    Spacer()
                }
                .navigationTitle("Ваши доходы")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
    
    private var content: some View {
        VStack {
            ForEach(salares, id: \.id) { salare in
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(salare.month)
                            .font(.headline)
                            .foregroundColor(.blue)
                        Text("Доход: $\(Int(salare.income))")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    Circle()
                        .fill(Color.green)
                        .frame(width: 40, height: 40)
                        .overlay(
                            Text("💰")
                                .font(.system(size: 24))
                        )
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color(UIColor.systemGray6)))
                .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 5)
                .padding(.horizontal)
                .padding(.vertical, 5)
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
    }
}
