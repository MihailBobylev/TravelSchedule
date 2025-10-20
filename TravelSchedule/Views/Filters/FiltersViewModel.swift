//
//  FiltersViewModel.swift
//  TravelSchedule
//
//  Created by Михаил Бобылев on 16.10.2025.
//

import Foundation
import SwiftUI

@Observable final class FiltersViewModel: ObservableObject {
    private var filtersModel: FiltersModel
    let localFiltersModel: FiltersModel
    
    init(filtersModel: FiltersModel) {
        self.filtersModel = filtersModel
        self.localFiltersModel = FiltersModel(copying: filtersModel)
    }
    
    func setTimeOfDay(_ time: TimeOfDay) {
        if localFiltersModel.times.contains(time) {
            localFiltersModel.times.remove(time)
        } else {
            localFiltersModel.times.insert(time)
        }
    }
    
    func saveFilters() {
        filtersModel.times = localFiltersModel.times
        filtersModel.transfer = localFiltersModel.transfer
        NotificationCenter.default.post(name: .refetchSchedule, object: nil)
    }
}
