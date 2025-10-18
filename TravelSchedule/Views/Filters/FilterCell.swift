//
//  FilterCell.swift
//  TravelSchedule
//
//  Created by Михаил Бобылев on 16.10.2025.
//

import SwiftUI

struct FilterCell: View {
    let title: String
    let isChecked: Bool
    let onToggle: () -> Void
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 16.dfs, weight: .regular))
                .foregroundColor(.baseFont)
            Spacer()
            Image(isChecked ? .icCheckboxOn : .icCheckboxOff)
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
    FilterCell(title: "Утро", isChecked: false, onToggle: {})
}
