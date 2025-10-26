//
//  CarrierViewModel.swift
//  TravelSchedule
//
//  Created by Михаил Бобылев on 25.10.2025.
//

import Foundation
import OpenAPIRuntime

@Observable final class CarrierViewModel {
    private var currentTask: Task<Void, Never>?
    private let servicesProvider: ServicesProvider
    private let code: Int
    
    var isLoading = false
    var requestError: ErrorType = .none
    var carrierInfo: Components.Schemas.Carrier?
    
    var isEmptyResult: Bool {
        !isLoading && carrierInfo == nil && requestError == .none
    }
    
    init(servicesProvider: ServicesProvider, code: Int) {
        self.servicesProvider = servicesProvider
        self.code = code
    }
    
    deinit {
        currentTask?.cancel()
    }
    
    func fetchCarrierInfo() {
        currentTask?.cancel()
        isLoading = true
        
        currentTask = Task {
            do {
                guard !Task.isCancelled else { return }
                let carrierInfo = try await servicesProvider.carrierInfoService.getCarrierInfo(code: code)
                await MainActor.run {
                    self.carrierInfo = carrierInfo
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
        self.isLoading = false
    }
}
