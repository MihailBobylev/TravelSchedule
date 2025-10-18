//
//  TripSelection.swift
//  TravelSchedule
//
//  Created by Михаил Бобылев on 12.10.2025.
//

import Foundation

final class TripSelection: ObservableObject {
    @Published var fromStation: Components.Schemas.Station?
    @Published var toStation: Components.Schemas.Station?
    @Published var currentSelection: TripSelectionType = .from
    
    func select(_ station: Components.Schemas.Station) {
        switch currentSelection {
        case .from:
            fromStation = station
        case .to:
            toStation = station
        }
    }
    
    func reverse() {
        guard let fromStation, let toStation else { return }
        let tmpState = fromStation
        self.fromStation = toStation
        self.toStation = tmpState
    }
}
