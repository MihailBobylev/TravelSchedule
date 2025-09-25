//
//  CopyrightService.swift
//  TravelSchedule
//
//  Created by Михаил Бобылев on 25.09.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias CopyrightResponse = Components.Schemas.CopyrightResponse

protocol CopyrightServiceProtocol {
    func getCopyright() async throws -> CopyrightResponse 
}

final class CopyrightService: CopyrightServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getCopyright() async throws -> CopyrightResponse {
        let response = try await client.getCopyright(query: .init(
            apikey: apikey)
        )
        return try response.ok.body.json
    }
}
