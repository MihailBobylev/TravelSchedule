//
//  StoryService.swift
//  TravelSchedule
//
//  Created by Михаил Бобылев on 26.10.2025.
//

import Foundation

final class StoryService: ObservableObject {
    @Published var stories: [StoryPack] = [
        .init(title: "Text Text Text Text Text Text Text Text Text",
              coverImageName: "first-ic-story",
              isViewed: false,
              stories: [
                .init(imageName: "first-full-1story",
                      title: "Text Text Text Text Text Text Text Text Text",
                      description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"),
                .init(imageName: "first-full-2story",
                      title: "Text Text Text Text Text Text Text Text Text",
                      description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text")
              ]),
        .init(title: "Text Text Text Text Text Text Text Text Text",
              coverImageName: "second-ic-story",
              isViewed: false,
              stories: [
                .init(imageName: "second-full-1story",
                      title: "Text Text Text Text Text Text Text Text Text",
                      description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"),
                .init(imageName: "second-full-2story",
                      title: "Text Text Text Text Text Text Text Text Text",
                      description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text")
              ]),
        .init(title: "Text Text Text Text Text Text Text Text Text",
              coverImageName: "third-ic-story",
              isViewed: false,
              stories: [
                .init(imageName: "third-full-1story",
                      title: "Text Text Text Text Text Text Text Text Text",
                      description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"),
                .init(imageName: "third-full-2story",
                      title: "Text Text Text Text Text Text Text Text Text",
                      description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text")
              ]),
        .init(title: "Text Text Text Text Text Text Text Text Text",
              coverImageName: "fourth-ic-story",
              isViewed: false,
              stories: [
                .init(imageName: "fourth-full-1story",
                      title: "Text Text Text Text Text Text Text Text Text",
                      description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"),
                .init(imageName: "fourth-full-2story",
                      title: "Text Text Text Text Text Text Text Text Text",
                      description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text")
              ])
    ]
    
    func markStoryPackAsViewed(_ pack: StoryPack) {
        guard let index = stories.firstIndex(where: { $0.id == pack.id }) else { return }
        stories[index].isViewed = true
    }
}
