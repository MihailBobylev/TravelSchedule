//
//  ServicesProvider.swift
//  TravelSchedule
//
//  Created by Михаил Бобылев on 12.10.2025.
//

import Foundation
import OpenAPIURLSession

final class ServicesProvider: ObservableObject {
    private let client: Client
    private let apikey: String
    
    lazy var allStationService = make(AllStationsService.self)
    lazy var carrierInfoService = make(CarrierInfoService.self)
    lazy var copyrightService = make(CopyrightService.self)
    lazy var nearestCityService = make(NearestCityService.self)
    lazy var nearestStationsService = make(NearestStationsService.self)
    lazy var routeStationsService = make(RouteStationsService.self)
    lazy var scheduleBetweenStationsService = make(ScheduleBetweenStationsService.self)
    lazy var stationScheduleService = make(StationScheduleService.self)
    
    init(apikey: String) throws {
        self.apikey = apikey
        let url = try Servers.Server1.url()
        self.client = Client(serverURL: url, transport: URLSessionTransport())
    }
    
    private func make<T>(_ type: T.Type) -> T where T: APIService {
        T(client: client, apikey: apikey)
    }
}
