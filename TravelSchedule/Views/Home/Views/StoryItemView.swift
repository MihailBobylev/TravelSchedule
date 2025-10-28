//
//  StoryItemView.swift
//  TravelSchedule
//
//  Created by Михаил Бобылев on 26.10.2025.
//

import SwiftUI

struct StoryItemView: View {
    let model: StoryPack
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Image(model.coverImageName)
                .resizable()
                .scaledToFill()
                .frame(width: 92.dhs, height: 140.dvs)
                .clipped()
                .cornerRadius(16)
                .opacity(model.isViewed ? 0.5 : 1.0)
            
            Text(model.title)
                .font(.system(size: 12.dfs, weight: .regular))
                .foregroundColor(.white)
                .padding(.horizontal, 8.dhs)
                .padding(.bottom, 12.dvs)
                .lineLimit(3)
        }
        .frame(width: 92.dhs, height: 140.dvs)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(model.isViewed ? .clear : .blueUniversal, lineWidth: 4)
        )
    }
}

#Preview {
    StoryItemView(model: .init(title: "Text Text Text Text Text Text Text Text Text",
                               coverImageName: "first-ic-story",
                               isViewed: false,
                               stories: []))
}
