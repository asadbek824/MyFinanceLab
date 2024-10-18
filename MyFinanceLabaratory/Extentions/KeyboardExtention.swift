//
//  KeyboardExtention.swift
//  MyFinanceLabaratory
//
//  Created by Asadbek Yoldoshev on 16/10/24.
//

import SwiftUI
import Combine

struct KeyboardAdaptive: ViewModifier {
    @State private var currentHeight: CGFloat = 0
    private var keyboardHeightPublisher: AnyPublisher<CGFloat, Never> {
        Publishers.Merge(
            NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
                .compactMap { $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect }
                .map { $0.height },
            NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
                .map { _ in CGFloat(0) }
        )
        .eraseToAnyPublisher()
    }

    func body(content: Content) -> some View {
        content
            .padding(.bottom, currentHeight)
            .onReceive(keyboardHeightPublisher) { height in
                currentHeight = height
            }
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
