//
//  HomeViewModel.swift
//  TravelSchedule
//
//  Created by Михаил Бобылев on 12.10.2025.
//

import Foundation

final class HomeViewModel: ObservableObject {
    let servicesProvider: ServicesProvider
    let tripSelection: TripSelection
    
    init(servicesProvider: ServicesProvider, tripSelection: TripSelection) {
        self.servicesProvider = servicesProvider
        self.tripSelection = tripSelection
    }
}
