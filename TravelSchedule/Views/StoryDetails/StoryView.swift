//
//  StoryView.swift
//  TravelSchedule
//
//  Created by Михаил Бобылев on 26.10.2025.
//

import SwiftUI

struct StoryView: View {
    let story: StoryItem

    var body: some View {
        Image(story.imageName)
            .resizable()
            .scaledToFit()
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: 40))
            .padding(.top, 7.dvs)
            .padding(.bottom, 17.dvs)
            .overlay(
                VStack {
                    Spacer()
                    VStack(alignment: .leading, spacing: 10.dvs) {
                        Text(story.title)
                            .font(.system(size: 34.dfs, weight: .bold))
                            .lineLimit(2)
                            .foregroundColor(.white)
                        Text(story.description)
                            .font(.system(size: 20.dfs, weight: .regular))
                            .lineLimit(3)
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal, 16.dhs)
                .padding(.bottom, 40.dvs)
            )
    }
}
