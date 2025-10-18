//
//  View+Extension.swift
//  TravelSchedule
//
//  Created by Михаил Бобылев on 15.10.2025.
//

import SwiftUI

extension View {
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
