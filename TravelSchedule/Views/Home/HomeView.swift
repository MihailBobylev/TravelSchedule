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
    @EnvironmentObject var storyService: StoryService
    private let viewModel: HomeViewModel
    
    init(tripSelection: TripSelection) {
        self.viewModel = HomeViewModel(tripSelection: tripSelection)
    }
    
    var body: some View {
        VStack(spacing: 44.dvs) {
            StoriesSectionView(storyPacks: storyService.stories) { pack in
                coordinator.showStoryDetailsView(storiesPack: pack)
            }
            .padding(.top, 20.dvs)
            
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
