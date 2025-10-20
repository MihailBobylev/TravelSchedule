//
//  ListCell.swift
//  TravelSchedule
//
//  Created by Михаил Бобылев on 11.10.2025.
//

import SwiftUI

struct ListCell: View {
    var name: String
    
    var body: some View {
        HStack {
            Text(name)
                .font(.system(size: 17.dfs, weight: .regular))
                .foregroundColor(.baseFont)
            Spacer()
            Image(.arrowRight)
        }
        .contentShape(Rectangle())
        .frame(height: 60.dvs)
    }
}

#Preview {
    ListCell(name: "Кострома")
}
