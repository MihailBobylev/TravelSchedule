//
//  HomeViewModel.swift
//  TravelSchedule
//
//  Created by Михаил Бобылев on 12.10.2025.
//

import Foundation

@MainActor
@Observable
final class HomeViewModel: ObservableObject {
    let tripSelection: TripSelection
    
    init(tripSelection: TripSelection) {
        self.tripSelection = tripSelection
    }
}
