//
//  StoryItemModel.swift
//  TravelSchedule
//
//  Created by Михаил Бобылев on 26.10.2025.
//

import Foundation

struct StoryItem: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    let description: String
}

struct StoryPack: Identifiable {
    let id = UUID()
    let title: String
    let coverImageName: String
    var isViewed: Bool
    let stories: [StoryItem]
}
