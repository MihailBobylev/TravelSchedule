//
//  CarrierViewModel.swift
//  TravelSchedule
//
//  Created by Михаил Бобылев on 25.10.2025.
//

import Foundation
import OpenAPIRuntime

@MainActor
@Observable
final class CarrierViewModel {
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

    func fetchCarrierInfo() async {
        isLoading = true
        requestError = .none
        carrierInfo = nil

        do {
            let carrierInfo = try await servicesProvider.carrierInfoService.getCarrierInfo(code: code)
            self.carrierInfo = carrierInfo
            self.isLoading = false
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

            print("Error fetchCarrierInfo: \(error.localizedDescription)")
            self.requestError = errorType
        }
    }
}
