//
//  FiltersModel.swift
//  TravelSchedule
//
//  Created by Михаил Бобылев on 16.10.2025.
//

import Foundation

enum TimeOfDay {
    case morning
    case afternoon
    case evening
    case night
    
    var title: String {
        return switch self {
        case .morning: "Утро 06:00 - 12:00"
        case .afternoon: "День 12:00 - 18:00"
        case .evening: "Вечер 18:00 - 00:00"
        case .night: "Ночь 00:00 - 06:00"
        }
    }
    
    func matches(departureString: String) -> Bool {
        let components = departureString.split(separator: ":")
        guard let hourString = components.first,
              let hour = Int(hourString)
        else { return false }
        return contains(hour: hour)
    }
    
    private func contains(hour: Int) -> Bool {
        switch self {
        case .morning:
            return (6...11).contains(hour)
        case .afternoon:
            return (12...17).contains(hour)
        case .evening:
            return (18...23).contains(hour)
        case .night:
            return (0...5).contains(hour)
        }
    }
}

enum TransferType: CaseIterable {
    case yes
    case no
    
    var title: String {
        return switch self {
        case .yes: "Да"
        case .no: "Нет"
        }
    }
    
    var value: Bool {
        return switch self {
        case .yes: true
        case .no: false
        }
    }
}

@Observable final class FiltersModel: ObservableObject {
    var times: Set<TimeOfDay> = []
    var transfer: TransferType = .no
    
    var filtersIsEmpty: Bool {
        times.isEmpty && transfer == .no
    }
    
    init(times: Set<TimeOfDay> = [], transfers: TransferType = .no) {
        self.times = times
        self.transfer = transfers
    }
    
    convenience init(copying model: FiltersModel) {
        self.init(times: model.times, transfers: model.transfer)
    }
}
