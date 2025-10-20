//
//  AllStationsService.swift
//  TravelSchedule
//
//  Created by Михаил Бобылев on 25.09.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession
import Foundation

typealias AllStationsResponse = Components.Schemas.AllStationsResponse

protocol AllStationsServiceProtocol {
    func getAllStations() async throws -> AllStationsResponse
}

final class AllStationsService: APIService, AllStationsServiceProtocol {
    private let decoder = JSONDecoder()
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getAllStations() async throws -> AllStationsResponse {
        let response = try await client.getAllStations(query: .init(apikey: apikey))
        
        let responseBody = try response.ok.body.html
        
        let limit = 50 * 1024 * 1024 // 50Mb
        let fullData = try await Data(collecting: responseBody, upTo: limit)
        
        let allStations = try decoder.decode(AllStationsResponse.self, from: fullData)
        
        return allStations
    }
}
