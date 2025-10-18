//
//  SplashView.swift
//  TravelSchedule
//
//  Created by Михаил Бобылев on 11.10.2025.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        Image("splash_screen1x")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
    }
}

#Preview {
    SplashView()
}
