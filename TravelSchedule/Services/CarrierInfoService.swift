//
//  CarrierInfoService.swift
//  TravelSchedule
//
//  Created by Михаил Бобылев on 25.09.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias Carrier = Components.Schemas.Carrier

protocol CarrierInfoServiceProtocol {
    func getCarrierInfo(code: Int) async throws -> Carrier?
}

final class CarrierInfoService: APIService, CarrierInfoServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getCarrierInfo(code: Int) async throws -> Carrier? {
        let response = try await client.getCarrierInfo(query: .init(
            apikey: apikey,
            code: code)
        )

        return try response.ok.body.json.carrier
    }
}
