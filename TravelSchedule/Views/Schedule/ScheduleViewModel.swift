//
//  CarriersViewModel.swift
//  TravelSchedule
//
//  Created by Михаил Бобылев on 14.10.2025.
//

import Foundation
import OpenAPIRuntime

@Observable final class ScheduleViewModel: ObservableObject {
    private var currentTask: Task<Void, Never>?
    private var hasFetched = false
    let filtersModel: FiltersModel
    
    let servicesProvider: ServicesProvider
    let tripSelection: TripSelection
    
    var schedules: [ScheduleModel] = []
    var isLoading = false
    var requestError: ErrorType = .none
    
    var isEmptyResult: Bool {
        !isLoading && schedules.isEmpty && requestError == .none
    }
    
    init(servicesProvider: ServicesProvider, tripSelection: TripSelection, filtersModel: FiltersModel) {
        self.servicesProvider = servicesProvider
        self.tripSelection = tripSelection
        self.filtersModel = filtersModel
        
        NotificationCenter.default.addObserver(self, selector: #selector(refetchSchedule), name: .refetchSchedule, object: nil)
    }
    
    deinit {
        currentTask?.cancel()
    }
    
    func fetchScheduleBetweenStations() {
        guard !hasFetched,
              let fromStationCode = tripSelection.fromStation?.codes?.yandex_code,
              let toStationCode = tripSelection.toStation?.codes?.yandex_code else { return }
        hasFetched = true
        currentTask?.cancel()
        isLoading = true
        
        currentTask = Task {
            do {
                let schedule = try await servicesProvider
                    .scheduleBetweenStationsService
                    .getScheduleBetweenStations(from: fromStationCode,
                                                to: toStationCode,
                                                transfers: filtersModel.transfer.value)
                guard !Task.isCancelled else { return }
                
                let models: [ScheduleModel] = schedule.segments?.compactMap { segment in
                    guard let carrier = segment.thread?.carrier,
                          let departure = segment.departure,
                          !filtersModel.times.isEmpty
                            ? filtersModel.times.contains(where: { $0.matches(departureString: departure) })
                            : true
                    else {
                        return nil
                    }
                    
                    return ScheduleModel(carrier: carrier,
                                         startDate: segment.start_date ?? "",
                                         departure: departure,
                                         arrival: segment.arrival ?? "",
                                         duration: segment.duration ?? 0,
                                         hasTransfers: segment.has_transfers ?? false)
                } ?? []
                
                await MainActor.run {
                    self.schedules = models
                    self.isLoading = false
                }
            } catch {
                await MainActor.run { isLoading = false }
                
                guard !Task.isCancelled else {
                    print("Fetch cancelled")
                    return
                }
                
                let errorType: ErrorType
                if let clientError = error as? OpenAPIRuntime.ClientError,
                   let urlError = clientError.underlyingError as? URLError,
                   urlError.code == .notConnectedToInternet {
                    errorType = .noInternet
                } else {
                    errorType = .serverError
                }
                
                print("Error fetchScheduleBetweenStations: \(error.localizedDescription)")
                await MainActor.run { requestError = errorType }
            }
        }
    }
    
    func cancelFetching() {
        currentTask?.cancel()
        isLoading = false
    }
    
    @objc private func refetchSchedule() {
        hasFetched = false
        fetchScheduleBetweenStations()
    }
}
