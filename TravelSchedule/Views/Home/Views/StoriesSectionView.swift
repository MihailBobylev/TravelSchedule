//
//  StoriesSectionView.swift
//  TravelSchedule
//
//  Created by Михаил Бобылев on 26.10.2025.
//

import SwiftUI

struct StoriesSectionView: View {
    let storyPacks: [StoryPack]
    var onSelect: (StoryPack) -> Void
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12.dhs) {
                ForEach(storyPacks) { pack in
                    Button {
                        onSelect(pack)
                    } label: {
                        StoryItemView(model: pack)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 16.dhs)
            .padding(.vertical, 4)
        }
    }
}
