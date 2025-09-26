//
//  SchedualBetweenStationsService.swift
//  TravelSchedule
//
//  Created by Михаил Бобылев on 25.09.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias Schedule = Components.Schemas.Segments

protocol ScheduleBetweenStationsServiceProtocol {
    func getScheduleBetweenStations(from: String, to: String) async throws -> Schedule
}

final class ScheduleBetweenStationsService: ScheduleBetweenStationsServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getScheduleBetweenStations(from: String, to: String) async throws -> Schedule {
        let response = try await client.getScheduleBetweenStations(query: .init(
            apikey: apikey,
            from: from,
            to: to)
        )
        return try response.ok.body.json
    }
}
