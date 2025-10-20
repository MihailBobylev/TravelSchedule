//
//  TransfersCell.swift
//  TravelSchedule
//
//  Created by Михаил Бобылев on 16.10.2025.
//

import SwiftUI

struct TransfersCell: View {
    let title: String
    let isSelected: Bool
    let onToggle: () -> Void
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 16.dfs, weight: .regular))
                .foregroundColor(.baseFont)
            Spacer()
            Image(isSelected ? .icRadioOn : .icRadioOff)
                .foregroundColor(.baseFont)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation {
                onToggle()
            }
        }
    }
}

#Preview {
    TransfersCell(title: "Да", isSelected: false, onToggle: {})
}
