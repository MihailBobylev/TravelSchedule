//
//  CarriersViewModel.swift
//  TravelSchedule
//
//  Created by Михаил Бобылев on 14.10.2025.
//

import Foundation
import OpenAPIRuntime

@MainActor
@Observable
final class ScheduleViewModel {
    private var hasFetched = false
    private var fetchTask: Task<Void, Never>?
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

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleRefetchNotification),
            name: .refetchSchedule,
            object: nil
        )
    }

    func fetchScheduleBetweenStations() async {
        guard !hasFetched,
              let fromStationCode = tripSelection.fromStation?.codes?.yandex_code,
              let toStationCode = tripSelection.toStation?.codes?.yandex_code
        else { return }

        hasFetched = true
        isLoading = true
        requestError = .none
        schedules = []

        do {
            let schedule = try await servicesProvider
                .scheduleBetweenStationsService
                .getScheduleBetweenStations(
                    from: fromStationCode,
                    to: toStationCode,
                    transfers: filtersModel.transfer.value
                )

            let models: [ScheduleModel] = schedule.segments?.compactMap { segment in
                guard let carrier = segment.thread?.carrier,
                      let departure = segment.departure,
                      !filtersModel.times.isEmpty
                        ? filtersModel.times.contains(where: { $0.matches(departureString: departure) })
                        : true
                else {
                    return nil
                }

                return ScheduleModel(
                    carrier: carrier,
                    startDate: segment.start_date ?? "",
                    departure: departure,
                    arrival: segment.arrival ?? "",
                    duration: segment.duration ?? 0,
                    hasTransfers: segment.has_transfers ?? false
                )
            } ?? []

            schedules = models
            isLoading = false
        } catch {
            isLoading = false

            let errorType: ErrorType
            if let clientError = error as? OpenAPIRuntime.ClientError,
               let urlError = clientError.underlyingError as? URLError,
               urlError.code == .notConnectedToInternet {
                errorType = .noInternet
            } else {
                errorType = .serverError
            }

            print("Error fetchScheduleBetweenStations: \(error.localizedDescription)")
            requestError = errorType
        }
    }

    private func refetchScheduleAsync() {
        fetchTask?.cancel()
        hasFetched = false
        fetchTask = Task {
            await fetchScheduleBetweenStations()
        }
    }

    @objc private func handleRefetchNotification() {
        refetchScheduleAsync()
    }
}
