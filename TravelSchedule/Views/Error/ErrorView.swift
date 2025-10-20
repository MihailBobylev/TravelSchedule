//
//  ErrorView.swift
//  TravelSchedule
//
//  Created by Михаил Бобылев on 15.10.2025.
//

import SwiftUI

enum ErrorType {
    case noInternet
    case serverError
    case none
    
    var image: Image? {
        return switch self {
        case .noInternet: Image(.ilNoInternet)
        case .serverError: Image(.ilServerError)
        case .none: nil
        }
    }
    
    var title: String {
        return switch self {
        case .noInternet: "Нет интернета"
        case .serverError: "Ошибка сервера"
        case .none: ""
        }
    }
}

struct ErrorView: View {
    let type: ErrorType
    
    var body: some View {
        VStack(spacing: 16.dvs) {
            type.image?
                .resizable()
                .scaledToFit()
                .frame(width: 223.dhs, height: 223.dhs)
            Text(type.title)
                .font(.system(size: 24.dfs, weight: .bold))
                .foregroundColor(.baseFont)
        }
    }
}

#Preview {
    ErrorView(type: .serverError)
}
