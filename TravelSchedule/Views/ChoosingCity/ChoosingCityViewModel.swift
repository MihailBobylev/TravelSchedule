//
//  ChoosingCityViewModel.swift
//  TravelSchedule
//
//  Created by Михаил Бобылев on 11.10.2025.
//

import Foundation
import OpenAPIRuntime

@Observable final class ChoosingCityViewModel {
    private var currentTask: Task<Void, Never>?
    private var searchTask: Task<Void, Never>?
    private var hasFetched = false
    let tripSelection: TripSelection
    
    var settlements: [Components.Schemas.Settlement] = []
    var filteredSettlements: [Components.Schemas.Settlement] = []
    
    var searchText: String = "" {
        didSet {
            scheduleFiltering()
        }
    }
    var isLoading = false
    var requestError: ErrorType = .none
    
    var isEmptyResult: Bool {
        !isLoading && filteredSettlements.isEmpty && requestError == .none
    }
    
    private let servicesProvider: ServicesProvider
    
    init(servicesProvider: ServicesProvider, tripSelection: TripSelection) {
        self.servicesProvider = servicesProvider
        self.tripSelection = tripSelection
    }
    
    deinit {
        currentTask?.cancel()
        searchTask?.cancel()
    }
    
    func fetchAllStations() {
        guard !hasFetched else { return }
        hasFetched = true
        currentTask?.cancel()
        isLoading = true
        
        currentTask = Task {
            do {
                let allStations = try await servicesProvider.allStationService.getAllStations()
                guard !Task.isCancelled else { return }
                
                let settlements: [Components.Schemas.Settlement] = allStations.countries?
                    .flatMap { $0.regions ?? [] }
                    .flatMap { $0.settlements ?? [] }
                    .compactMap { settlement in
                        settlement.title != "" ? settlement : nil
                    } ?? []
                
                await MainActor.run {
                    self.settlements = settlements
                    self.filteredSettlements = settlements
                    self.isLoading = false
                }
                
                print("Successfully fetched all stations: \(settlements.count)")
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
                
                await MainActor.run { requestError = errorType }
            }
        }
    }
    
    func cancelFetching() {
        currentTask?.cancel()
        searchTask?.cancel()
        self.isLoading = false
    }
    
    private func scheduleFiltering() {
        searchTask?.cancel()
        
        searchTask = Task { [weak self] in
            try? await Task.sleep(nanoseconds: 300_000_000)
            guard !Task.isCancelled, let self else { return }

            let query = self.searchText.trimmingCharacters(in: .whitespacesAndNewlines)
            if query.isEmpty {
                await MainActor.run { self.filteredSettlements = self.settlements }
                return
            }

            let filtered = self.settlements.filter {
                guard let title = $0.title else { return false }
                return title.range(of: query, options: [.caseInsensitive, .diacriticInsensitive]) != nil
            }

            await MainActor.run { self.filteredSettlements = filtered }
        }
    }
}
