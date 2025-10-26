//
//  UserAgreementView.swift
//  TravelSchedule
//
//  Created by Михаил Бобылев on 25.10.2025.
//

import SwiftUI
import WebKit

struct UserAgreementView: View {
    var body: some View {
        Group {
            if let agreementURL = URL(string: "https://yandex.ru/legal/practicum_offer/ru/") {
                WebView(url: agreementURL)
            } else {
                Text("Не удалось загрузить пользовательское соглашение")
            }
        }
        .navigationTitle("Пользовательское соглашение")
        .navigationBarHidden(false)
    }
}

#Preview {
    UserAgreementView()
}
