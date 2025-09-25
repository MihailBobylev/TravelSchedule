//
//  NearestCityService.swift
//  TravelSchedule
//
//  Created by Михаил Бобылев on 25.09.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias NearestCityResponse = Components.Schemas.NearestCityResponse

protocol NearestCityServiceProtocol {
    func getNearestStations(lat: Double, lng: Double, distance: Int?) async throws -> NearestCityResponse
}

final class NearestCityService: NearestCityServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getNearestStations(lat: Double, lng: Double, distance: Int?) async throws -> NearestCityResponse {
        let response = try await client.getNearestCity(query: .init(
            apikey: apikey,
            lat: lat,
            lng: lng,
            distance: distance)
        )
        return try response.ok.body.json
    }
}
