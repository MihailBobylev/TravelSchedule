//
//  FiltersView.swift
//  TravelSchedule
//
//  Created by Михаил Бобылев on 16.10.2025.
//

import SwiftUI

struct FiltersView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    @ObservedObject private var viewModel: FiltersViewModel
    
    init(filtersModel: FiltersModel) {
        self.viewModel = FiltersViewModel(filtersModel: filtersModel)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 38.dvs) {
            Text("Время отправления")
                .font(.system(size: 24.dfs, weight: .bold))
                .foregroundColor(.baseFont)
                .padding(.top, 16.dvs)
            ForEach([TimeOfDay.morning, .afternoon, .evening, .night], id: \.self) { time in
                FilterCell(
                    title: time.title,
                    isChecked: viewModel.localFiltersModel.times.contains(time),
                    onToggle: {
                        viewModel.setTimeOfDay(time)
                    }
                )
            }
            
            Text("Показывать варианты с пересадками")
                .font(.system(size: 24.dfs, weight: .bold))
                .foregroundColor(.baseFont)
            
            ForEach(TransferType.allCases, id: \.self) { transfer in
                TransfersCell(title: transfer.title,
                              isSelected: viewModel.localFiltersModel.transfer == transfer) {
                    viewModel.localFiltersModel.transfer = transfer
                }
            }
            Spacer()
            Button(action: {
                viewModel.saveFilters()
                coordinator.popViewController()
            }) {
                Text("Применить")
                    .foregroundColor(.white)
                    .font(.system(size: 17.dfs, weight: .bold))
                    .frame(maxWidth: .infinity)
                    .frame(height: 60.dvs)
                    .background(.blueUniversal)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
        }
        .navigationBarHidden(false)
        .padding(.horizontal, 16.dhs)
    }
}

#Preview {
    FiltersView(filtersModel: FiltersModel())
}
