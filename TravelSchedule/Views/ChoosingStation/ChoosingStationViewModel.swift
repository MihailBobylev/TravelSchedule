//
//  ChoosingStationViewModel.swift
//  TravelSchedule
//
//  Created by Михаил Бобылев on 12.10.2025.
//

import Foundation
import OpenAPIURLSession

@Observable final class ChoosingStationViewModel {
    let tripSelection: TripSelection
    
    let stations: [Components.Schemas.Station]
    var searchText: String = ""
    
    var filteredStations: [Components.Schemas.Station] {
        if searchText.isEmpty {
            return stations
        } else {
            return stations.filter { station in
                if let title = station.title {
                    return title.localizedCaseInsensitiveContains(searchText)
                }
                return false
            }
        }
    }
    
    init(stations: [Components.Schemas.Station], tripSelection: TripSelection) {
        self.stations = stations
        self.tripSelection = tripSelection
    }
}
