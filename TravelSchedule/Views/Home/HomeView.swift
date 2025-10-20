//
//  ContentView.swift
//  TravelSchedule
//
//  Created by Михаил Бобылев on 25.09.2025.
//

import SwiftUI
import OpenAPIURLSession

struct HomeView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    private let viewModel: HomeViewModel
    
    init(servicesProvider: ServicesProvider, tripSelection: TripSelection) {
        self.viewModel = HomeViewModel(servicesProvider: servicesProvider, tripSelection: tripSelection)
    }
    
    var body: some View {
        VStack {
            DestinationView(tripSelection: viewModel.tripSelection, actionFrom: {
                coordinator.showChoosingCityView(type: .from)
            }, actionTo: {
                coordinator.showChoosingCityView(type: .to)
            }, reverseDestination: {
                viewModel.tripSelection.reverse()
            }, findSchedule: {
                coordinator.showScheduleView()
            })
            Spacer()
        }
        .navigationBarHidden(true)
    }
}

//#Preview {
    //HomeView(servicesProvider: )
//}
