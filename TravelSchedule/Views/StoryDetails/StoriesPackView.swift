//
//  StoriesPackView.swift
//  TravelSchedule
//
//  Created by Михаил Бобылев on 26.10.2025.
//

import SwiftUI

struct StoriesPackView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    @EnvironmentObject var storyService: StoryService
    @State var currentStoryIndex: Int = 0
    @State var currentProgress: CGFloat = 0
    private var timerConfiguration: TimerConfiguration { .init(storiesCount: storiesPack.stories.count) }
    let storiesPack: StoryPack

    var body: some View {
        ZStack(alignment: .topTrailing) {
            StoriesTabView(storiesPack: storiesPack, currentStoryIndex: $currentStoryIndex)
                .onChange(of: currentStoryIndex) { oldValue, newValue in
                    didChangeCurrentIndex(oldIndex: oldValue, newIndex: newValue)
                    if newValue == storiesPack.stories.count - 1 {
                        markPackAsViewed()
                    }
                }

            StoriesProgressBar(
                storiesCount: storiesPack.stories.count,
                timerConfiguration: timerConfiguration,
                currentProgress: $currentProgress
            )
            .padding(.init(top: 35.dvs, leading: 12.dhs, bottom: 12.dvs, trailing: 12.dhs))
            .onChange(of: currentProgress) { _, newValue in
                didChangeCurrentProgress(newProgress: newValue)
            }
        }
        .background(.black)
    }
    
    private func markPackAsViewed() {
        storyService.markStoryPackAsViewed(storiesPack)
    }
    
    private func didChangeCurrentIndex(oldIndex: Int, newIndex: Int) {
        guard oldIndex != newIndex else { return }
        let progress = timerConfiguration.progress(for: newIndex)
        guard abs(progress - currentProgress) >= 0.01 else { return }
        withAnimation {
            currentProgress = progress
        }
    }

    private func didChangeCurrentProgress(newProgress: CGFloat) {
        if newProgress >= 1.0 && currentStoryIndex == storiesPack.stories.count - 1 {
            coordinator.dismiss()
            return
        }
        
        let index = timerConfiguration.index(for: newProgress)
        guard index != currentStoryIndex else { return }
        withAnimation {
            currentStoryIndex = index
        }
    }
}
