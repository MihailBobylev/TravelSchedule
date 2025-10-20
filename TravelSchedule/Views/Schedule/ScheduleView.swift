//
//  CarriersView.swift
//  TravelSchedule
//
//  Created by Михаил Бобылев on 14.10.2025.
//

import SwiftUI

struct ScheduleView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    private let viewModel: ScheduleViewModel
    
    init(servicesProvider: ServicesProvider, tripSelection: TripSelection, filtersModel: FiltersModel) {
        self.viewModel = ScheduleViewModel(servicesProvider: servicesProvider,
                                           tripSelection: tripSelection,
                                           filtersModel: filtersModel)
    }
    
    private var state: ViewState {
        if viewModel.requestError != .none {  return .error(viewModel.requestError) }
        if viewModel.isLoading { return .loading }
        if viewModel.isEmptyResult { return .empty }
        return .content
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16.dvs) {
            if state != .error(viewModel.requestError) {
                Text("\(viewModel.tripSelection.fromStation?.title ?? "") → \(viewModel.tripSelection.toStation?.title ?? "")")
                    .font(.system(size: 24.dfs, weight: .bold))
                    .foregroundColor(.baseFont)
                    .padding(.horizontal, 16.dhs)
            }
            
            ZStack {
                switch state {
                case .loading:
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(2)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                case .empty:
                    Text("Вариантов нет")
                        .font(.system(size: 24.dfs, weight: .bold))
                        .foregroundColor(.baseFont)
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                case .content:
                    List(viewModel.schedules, id: \.self) { schedule in
                        ScheduleCell(model: schedule)
                            .listRowSeparator(.hidden)
                            .listRowInsets(.init(top: 0, leading: 16.dhs, bottom: 8.dvs, trailing: 16.dhs))
                            .onTapGesture {
                                coordinator.showCarrierDetailsView()
                            }
                    }
                    .listStyle(.plain)
                    .safeAreaInset(edge: .bottom) {
                        Color.clear.frame(height: 100.dvs)
                    }
                    
                case .error(let type):
                    ErrorView(type: type)
                }

                if !(viewModel.isEmptyResult && viewModel.filtersModel.filtersIsEmpty)
                    && state != .error(viewModel.requestError)
                    && state != .loading {
                    VStack {
                        Spacer()
                        Button(action: {
                            coordinator.showFiltersView()
                        }) {
                            HStack(alignment: .center, spacing: 4) {
                                Text("Уточнить время")
                                    .foregroundColor(.white)
                                    .font(.system(size: 17.dfs, weight: .bold))
                                if !viewModel.filtersModel.filtersIsEmpty {
                                    Circle()
                                        .fill(.redUniversal)
                                        .frame(width: 8, height: 8)
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 60.dvs)
                            .background(.blueUniversal)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        }
                        .padding(.horizontal, 16.dhs)
                        .transition(.opacity)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                    .padding(.bottom, 24.dvs)
                }
            }
        }
        .navigationBarHidden(false)
        .onAppear {
            viewModel.fetchScheduleBetweenStations()
        }
        .onDisappear {
            viewModel.cancelFetching()
        }
    }
}

//#Preview {
//    ScheduleView(servicesProvider: ServicesProvider(apikey: ""),
//                 tripSelection: TripSelection())
//}
