//
//  RouteStationsService.swift
//  TravelSchedule
//
//  Created by Михаил Бобылев on 25.09.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias ThreadStationsResponse = Components.Schemas.ThreadStationsResponse

protocol RouteStationsServiceProtocol {
    func getRouteStations(uid: String) async throws -> ThreadStationsResponse
}

final class RouteStationsService: RouteStationsServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getRouteStations(uid: String) async throws -> ThreadStationsResponse {
        let response = try await client.getRouteStations(query: .init(
            apikey: apikey,
            uid: uid)
        )
        return try response.ok.body.json
    }
}
