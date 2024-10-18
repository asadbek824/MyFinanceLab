//
//  CircularProgressView.swift
//  MyFinanceLabaratory
//
//  Created by Asadbek Yoldoshev on 18/10/24.
//

import SwiftUI

struct CircularProgressView: View {
    var progress: Double // progress in percentage, from 0.0 to 1.0
    
    var body: some View {
        let validProgress = progress.isNaN || !progress.isFinite ? 0.0 : progress // handle NaN and infinity

        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.3), lineWidth: 5) // background circle
            Circle()
                .trim(from: 0.0, to: CGFloat(validProgress)) // progress circle
                .stroke(Color.blue, lineWidth: 5)
                .rotationEffect(Angle(degrees: -90)) // start the progress from the top
            Text("\(Int(validProgress * 100))%") // percentage label
                .font(.caption)
                .bold()
        }
    }
}
