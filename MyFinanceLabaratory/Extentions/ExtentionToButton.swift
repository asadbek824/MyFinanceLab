//
//  ExtentionToButton.swift
//  MyFinanceLabaratory
//
//  Created by Asadbek Yoldoshev on 18/10/24.
//

import SwiftUI

extension Button {
    func alertButtonStyle(isPrimary: Bool = false) -> some View {
        self
            .frame(maxWidth: .infinity)
            .padding()
            .background(isPrimary ? Color.blue : Color.gray)
            .foregroundColor(.white)
            .cornerRadius(8)
            .padding(.horizontal, 8)
    }
}
