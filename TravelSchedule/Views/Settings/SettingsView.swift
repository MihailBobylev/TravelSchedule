//
//  SettingsView.swift
//  TravelSchedule
//
//  Created by Михаил Бобылев on 13.10.2025.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            HStack {
                Text("Темная тема")
                    .font(.system(size: 17.dfs, weight: .regular))
                    .foregroundColor(.baseFont)
                Spacer()
                Toggle("", isOn: $isDarkMode)
                    .labelsHidden()
                    .tint(.blueUniversal)
            }
            .contentShape(Rectangle())
            .frame(height: 60.dvs)
            HStack {
                Text("Пользовательское соглашение")
                    .font(.system(size: 17.dfs, weight: .regular))
                    .foregroundColor(.baseFont)
                Spacer()
                Image(.arrowRight)
            }
            .contentShape(Rectangle())
            .frame(height: 60.dvs)
            .onTapGesture {
                coordinator.showUserAgreementView()
            }
            Spacer()
            Text("Приложение использует API «Яндекс.Расписания»")
                .font(.system(size: 12.dfs, weight: .regular))
                .foregroundColor(.baseFont)
                .padding(.bottom, 16.dvs)
            Text("Версия 1.0 (beta)")
                .font(.system(size: 12.dfs, weight: .regular))
                .foregroundColor(.baseFont)
        }
        .navigationBarHidden(true)
        .padding(.top, 24.dvs)
        .padding(.horizontal, 16.dhs)
        .padding(.bottom, 24.dvs)
    }
}

#Preview {
    SettingsView()
}
