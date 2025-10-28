//
//  StoriesTabView.swift
//  TravelSchedule
//
//  Created by Михаил Бобылев on 26.10.2025.
//

import SwiftUI

struct StoriesTabView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    let storiesPack: StoryPack
    @Binding var currentStoryIndex: Int

    var body: some View {
        TabView(selection: $currentStoryIndex) {
            ForEach(Array(storiesPack.stories.enumerated()), id: \.element.id) { index, story in
                StoryView(story: story)
                    .tag(index)
                    .onTapGesture {
                        didTapStory()
                    }
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .background(.black)
    }

    func didTapStory() {
        let oldValue = currentStoryIndex
        let newValue = min(currentStoryIndex + 1, storiesPack.stories.count - 1)
        
        if oldValue == newValue {
            coordinator.dismiss()
        } else {
            currentStoryIndex = newValue
        }
    }
}
