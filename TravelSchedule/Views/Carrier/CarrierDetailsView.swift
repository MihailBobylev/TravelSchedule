//
//  CarrierView.swift
//  TravelSchedule
//
//  Created by Михаил Бобылев on 18.10.2025.
//

import SwiftUI

struct CarrierDetailsView: View {
    private let viewModel: CarrierViewModel

    init(servicesProvider: ServicesProvider, code: Int) {
        self.viewModel = CarrierViewModel(servicesProvider: servicesProvider, code: code)
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
                Text("Информация не найдена")
                    .font(.system(size: 24.dfs, weight: .bold))
                    .foregroundColor(.baseFont)
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

            case .error(let type):
                ErrorView(type: type)

            case .content:
                VStack(alignment: .leading, spacing: 0) {
                    if let url = URL(string: viewModel.carrierInfo?.logo ?? "") {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(height: 104.dvs)
                                .frame(maxWidth: UIScreen.main.bounds.width - 32.dhs)
                                .clipped()
                                .clipShape(RoundedRectangle(cornerRadius: 24))
                                .padding(.bottom, 16.dvs)
                        } placeholder: {
                            Image(.imagePlaceholder)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 104.dvs)
                                .frame(maxWidth: UIScreen.main.bounds.width - 32.dhs)
                                .opacity(0.3)
                                .clipShape(RoundedRectangle(cornerRadius: 24))
                                .padding(.bottom, 16.dvs)
                        }
                    } else {
                        Image(.imagePlaceholder)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 104.dvs)
                            .frame(maxWidth: UIScreen.main.bounds.width - 32.dhs)
                            .clipShape(RoundedRectangle(cornerRadius: 24))
                            .padding(.bottom, 16.dvs)
                    }
                    Text(viewModel.carrierInfo?.title ?? "")
                        .font(.system(size: 24.dfs, weight: .bold))
                        .foregroundColor(.baseFont)
                        .padding(.bottom, 28.dvs)
                    Text("E-mail")
                        .font(.system(size: 17.dfs, weight: .regular))
                        .foregroundColor(.baseFont)
                    if let email = viewModel.carrierInfo?.email, !email.isEmpty, let emailURL = URL(string: "mailto:\(email)") {
                        Link(email, destination: emailURL)
                            .font(.system(size: 12.dfs, weight: .regular))
                            .padding(.bottom, 24.dvs)
                    } else {
                        Text("Отсутствует")
                            .font(.system(size: 12.dfs, weight: .regular))
                            .padding(.bottom, 24.dvs)
                            .foregroundColor(.baseFont)
                    }
                    Text("Телефон")
                        .font(.system(size: 17.dfs, weight: .regular))
                        .foregroundColor(.baseFont)
                    if let phone = viewModel.carrierInfo?.phone, !phone.isEmpty, let phoneURL = URL(string: "tel:\(phone)") {
                        Link(phone, destination: phoneURL)
                            .font(.system(size: 12.dfs, weight: .regular))
                    } else {
                        Text("Отсутствует")
                            .font(.system(size: 12.dfs, weight: .regular))
                            .padding(.bottom, 24.dvs)
                            .foregroundColor(.baseFont)
                    }
                    Spacer()
                }
            }
        }
        .padding(.top, 16.dvs)
        .navigationTitle("Информация о перевозчике")
        .onAppear { viewModel.fetchCarrierInfo() }
        .onDisappear { viewModel.cancelFetching() }
    }
}
