//
//  ContentView.swift
//  TravelSchedule
//
//  Created by Михаил Бобылев on 25.09.2025.
//

import SwiftUI
import OpenAPIURLSession

struct ContentView: View {
    private let apikey = "deb309ef-bb5d-4fa4-bc10-72b1697f3b00"
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            //testFetchStations()
            //testFetchScheduleBetweenStations()
            //testFetchStationSchedule()
            //testFetchRouteStations()
            //testFetchNearestCity()
            //testFetchCarrierInfo()
            //testFetchAllStations()
            //testFetchCopyright()
        }
    }
    
    func testFetchStations() {
        Task {
            do {
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport()
                )
                
                let service = NearestStationsService(
                    client: client,
                    apikey: apikey
                )
                
                print("Fetching stations...")
                let stations = try await service.getNearestStations(
                    lat: 59.864177,
                    lng: 30.319163,
                    distance: 50
                )
                
                print("Successfully fetched stations: \(stations)")
            } catch {
                print("Error fetching stations: \(error)")
            }
        }
    }
    
    func testFetchScheduleBetweenStations() {
        Task {
            do {
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport()
                )
                
                let service = ScheduleBetweenStationsService(
                    client: client,
                    apikey: apikey
                )
                
                print("Fetching schedule...")
                let schedule = try await service.getScheduleBetweenStations(from: "c146", to: "c213")
                print("Successfully fetched schedule: \(schedule)")
            } catch {
                print("Error fetching stations: \(error)")
            }
        }
    }
    
    func testFetchStationSchedule() {
        Task {
            do {
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport()
                )
                
                let service = StationScheduleService(
                    client: client,
                    apikey: apikey
                )
                
                print("Fetching station schedule...")
                let stationSchedule = try await service.getStationSchedule(station: "s9600213")
                print("Successfully fetched station schedule: \(stationSchedule)")
            } catch {
                print("Error fetching station stations: \(error)")
            }
        }
    }
    
    func testFetchRouteStations() {
        Task {
            do {
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport()
                )
                
                let service = RouteStationsService(
                    client: client,
                    apikey: apikey
                )
                
                print("Fetching route stations...")
                let routeStations = try await service.getRouteStations(uid: "098S_2_2")
                print("Successfully fetched route stations: \(routeStations)")
            } catch {
                print("Error fetching route stations: \(error)")
            }
        }
    }
    
    func testFetchNearestCity() {
        Task {
            do {
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport()
                )
                
                let service = NearestCityService(
                    client: client,
                    apikey: apikey
                )
                
                print("Fetching nearest city...")
                let nearestCity = try await service.getNearestStations(lat: 50.440046, lng: 40.4882367, distance: 50)
                print("Successfully fetched nearest city: \(nearestCity)")
            } catch {
                print("Error fetching nearest city: \(error)")
            }
        }
    }
    
    func testFetchCarrierInfo() {
        Task {
            do {
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport()
                )
                
                let service = CarrierInfoService(
                    client: client,
                    apikey: apikey
                )
                
                print("Fetching carrier info...")
                let carrierInfo = try await service.getCarrierInfo(code: "TK", system: "iata")
                print("Successfully fetched carrier info: \(carrierInfo)")
            } catch {
                print("Error fetching carrier info: \(error)")
            }
        }
    }
    
    func testFetchAllStations() {
        Task {
            do {
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport()
                )
                
                let service = AllStationsService(
                    client: client,
                    apikey: apikey
                )
                
                print("Fetching all stations...")
                let allStations = try await service.getAllStations()
                print("Successfully fetched all stations: \(allStations)")
            } catch {
                print("Error fetching all stations: \(error)")
            }
        }
    }
    
    func testFetchCopyright() {
        Task {
            do {
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport()
                )
                
                let service = CopyrightService(
                    client: client,
                    apikey: apikey
                )
                
                print("Fetching copyright...")
                let copyright = try await service.getCopyright()
                print("Successfully fetched copyright: \(copyright)")
            } catch {
                print("Error fetching copyright: \(error)")
            }
        }
    }
}

#Preview {
    ContentView()
}
