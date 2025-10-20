//
//  ChoosingCity.swift
//  TravelSchedule
//
//  Created by Михаил Бобылев on 11.10.2025.
//

import SwiftUI

struct ChoosingCityView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    @State private var searchText = ""
    
    private let viewModel: ChoosingCityViewModel

    init(servicesProvider: ServicesProvider, tripSelection: TripSelection) {
        self.viewModel = ChoosingCityViewModel(servicesProvider: servicesProvider, tripSelection: tripSelection)
    }

    private var state: ViewState {
        if viewModel.requestError != .none { return .error(viewModel.requestError) }
        if viewModel.isLoading { return .loading }
        if viewModel.isEmptyResult { return .empty }
        return .content
    }

    var body: some View {
        Group {
            switch state {
            case .loading:
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(2)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

            case .empty:
                Text("Город не найден")
                    .font(.system(size: 24.dfs, weight: .bold))
                    .foregroundColor(.baseFont)
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

            case .error(let type):
                ErrorView(type: type)

            case .content:
                List(viewModel.filteredSettlements, id: \.self) { settlement in
                    ListCell(name: settlement.title ?? "")
                        .listRowSeparator(.hidden)
                        .listRowInsets(.init(top: 0, leading: 16.dhs, bottom: 0, trailing: 16.dhs))
                        .onTapGesture {
                            coordinator.showChoosingStationView(settlement: settlement)
                        }
                }
                .listStyle(.plain)
            }
        }
        .navigationBarHidden(false)
        .navigationTitle("Выбор города")
        .if(state != .error(viewModel.requestError)) { view in
            view.searchable(text: $searchText, prompt: "Введите запрос")
        }
        .disabled(state == .loading)
        .onChange(of: searchText) { oldValue, newValue in
            viewModel.searchText = newValue
        }
        .onAppear { viewModel.fetchAllStations() }
        .onDisappear { viewModel.cancelFetching() }
    }
}

//#Preview {
//    ChoosingCityView()
//}
