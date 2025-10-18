//
//  CarrierCell.swift
//  TravelSchedule
//
//  Created by Михаил Бобылев on 14.10.2025.
//

import SwiftUI

struct ScheduleCell: View {
    let model: ScheduleModel
    
    var body: some View {
        VStack(spacing: 18.dvs) {
            HStack(alignment: .center) {
                if let url = URL(string: model.carrier.logo ?? "") {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        Image(.icBrand)
                            .resizable()
                            .scaledToFit()
                            .opacity(0.3)
                    }
                    .frame(width: 38, height: 38)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                } else {
                    Image(.icBrand)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 38, height: 38)
                }
                VStack(alignment: .leading, spacing: 2) {
                    Text(model.carrier.title ?? "")
                        .font(.system(size: 17.dfs, weight: .regular))
                        .foregroundColor(.black)
                    if model.hasTransfers {
                        Text("С пересадкой")
                            .font(.system(size: 12.dfs, weight: .regular))
                            .foregroundColor(.redUniversal)
                    }
                }
                Spacer()
                Text(model.formattedStartDate)
                    .font(.system(size: 12.dfs, weight: .regular))
                    .foregroundColor(.black)
            }
            .padding(.leading, 14.dhs)
            .padding(.trailing, 8.dhs)
            .padding(.top, 14.dvs)
            
            HStack {
                Text(model.formattedDeparture)
                    .font(.system(size: 17.dfs, weight: .regular))
                    .foregroundColor(.black)
                Rectangle()
                        .frame(height: 1)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.grayUniversal)
                Text(model.formattedDuration)
                    .font(.system(size: 12.dfs, weight: .regular))
                    .foregroundColor(.black)
                Rectangle()
                        .frame(height: 1)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.grayUniversal)
                Text(model.formattedArrival)
                    .font(.system(size: 17.dfs, weight: .regular))
                    .foregroundColor(.black)
            }
            .padding(.horizontal, 14.dhs)
            .padding(.bottom, 14.dvs)
        }
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(.lightGrayUniversal)
        )
    }
}

//#Preview {
//    ScheduleCell(model: .init(carrierTitle: "РЖД",
//                              carrierLogo: "https://yastat.net/s3/rasp/media/data/company/logo/doss.jpg",
//                              startDate: "2025-12-23",
//                              departure: "10:40:00",
//                              arrival: "23:40:00",
//                              duration: 133200,
//                              hasTransfers: false))
//}
