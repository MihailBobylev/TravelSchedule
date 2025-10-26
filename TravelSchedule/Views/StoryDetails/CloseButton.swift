//
//  CloseButton.swift
//  TravelSchedule
//
//  Created by Михаил Бобылев on 26.10.2025.
//

import SwiftUI

struct CloseButton: View {
    let action: () -> Void

    var body: some View {
        Button("", image: .icClose) {
            action()
        }
    }
}
