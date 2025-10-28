//
//  StoryDetailsView.swift
//  TravelSchedule
//
//  Created by Михаил Бобылев on 26.10.2025.
//

import SwiftUI

struct StoryDetailsView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    let storiesPack: StoryPack

    var body: some View {
        ZStack(alignment: .topTrailing) {
            StoriesPackView(storiesPack: storiesPack)
            CloseButton(action: {
                coordinator.dismiss()
            })
            .padding(.top, 57.dvs)
            .padding(.trailing, 12.dhs)
        }
    }
}
