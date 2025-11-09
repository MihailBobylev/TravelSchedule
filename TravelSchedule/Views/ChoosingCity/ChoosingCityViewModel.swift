//
//  ChoosingCityViewModel.swift
//  TravelSchedule
//
//  Created by Михаил Бобылев on 11.10.2025.
//

import Foundation
import OpenAPIRuntime

@MainActor
@Observable
final class ChoosingCityViewModel {
    private let servicesProvider: ServicesProvider
    private var hasFetched = false
    private var filterTask: Task<Void, Never>?
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
    
    init(servicesProvider: ServicesProvider, tripSelection: TripSelection) {
        self.servicesProvider = servicesProvider
        self.tripSelection = tripSelection
    }
    
    func fetchAllStations() async {
        guard !hasFetched else { return }
        hasFetched = true
        isLoading = true
        
        do {
            let allStations = try await servicesProvider.allStationService.getAllStations()
            let settlements: [Components.Schemas.Settlement] = allStations.countries?
                .flatMap { $0.regions ?? [] }
                .flatMap { $0.settlements ?? [] }
                .compactMap { settlement in
                    settlement.title?.isEmpty == false ? settlement : nil
                } ?? []
            
            self.settlements = settlements
            self.filteredSettlements = settlements
            self.isLoading = false
            print("Successfully fetched all stations: \(settlements.count)")
        } catch {
            self.isLoading = false
            
            let errorType: ErrorType
            if let clientError = error as? OpenAPIRuntime.ClientError,
               let urlError = clientError.underlyingError as? URLError,
               urlError.code == .notConnectedToInternet {
                errorType = .noInternet
            } else {
                errorType = .serverError
            }
            
            self.requestError = errorType
        }
    }
    
    private func scheduleFiltering() {
        filterTask?.cancel()
        filterTask = Task { [settlements, searchText] in
            try? await Task.sleep(nanoseconds: 300_000_000)
            guard !Task.isCancelled else { return }
            
            let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let filtered: [Components.Schemas.Settlement]
            if query.isEmpty {
                filtered = settlements
            } else {
                filtered = settlements.filter {
                    guard let title = $0.title else { return false }
                    return title.range(of: query, options: [.caseInsensitive, .diacriticInsensitive]) != nil
                }
            }
            self.filteredSettlements = filtered
        }
    }
}
