//
//  ChoosingStation.swift
//  TravelSchedule
//
//  Created by Михаил Бобылев on 12.10.2025.
//

import SwiftUI

struct ChoosingStationView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    @State private var searchText = ""
    @State private var searchTask: Task<Void, Never>?
    
    private let viewModel: ChoosingStationViewModel
    
    init(stations: [Components.Schemas.Station], tripSelection: TripSelection) {
        self.viewModel = ChoosingStationViewModel(stations: stations, tripSelection: tripSelection)
    }
    
    var body: some View {
        Group {
            if !viewModel.stations.isEmpty && viewModel.filteredStations.isEmpty {
                VStack {
                    Spacer()
                    Text("Станция не найдена")
                        .foregroundColor(.baseFont)
                        .font(.system(size: 24.dfs, weight: .bold))
                    Spacer()
                }
            } else {
                List(viewModel.filteredStations, id: \.self) { station in
                    ListCell(name: station.title ?? "")
                        .listRowSeparator(.hidden)
                        .listRowInsets(.init(top: 0, leading: 16.dhs, bottom: 0, trailing: 16.dhs))
                        .onTapGesture {
                            viewModel.tripSelection.select(station)
                            coordinator.popToRoot()
                        }
                }
                .listStyle(.plain)
            }
        }
        .navigationBarHidden(false)
        .navigationTitle("Выбор станции")
        .searchable(text: $searchText, prompt: "Введите запрос")
        .onChange(of: searchText) { oldValue, newValue in
            searchTask?.cancel()

            searchTask = Task {
                try? await Task.sleep(nanoseconds: 300_000_000)
                guard !Task.isCancelled else { return }

                await MainActor.run {
                    viewModel.searchText = newValue
                }
            }
        }
    }
}

//#Preview {
//    ChoosingStationView()
//}
