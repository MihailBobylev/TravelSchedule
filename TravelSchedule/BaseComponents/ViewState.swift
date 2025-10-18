//
//  ViewState.swift
//  TravelSchedule
//
//  Created by Михаил Бобылев on 15.10.2025.
//

import Foundation

enum ViewState: Equatable {
    case loading
    case empty
    case content
    case error(ErrorType)

    static func == (lhs: ViewState, rhs: ViewState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading), (.empty, .empty), (.content, .content):
            return true
        case (.error(let l), .error(let r)):
            return l == r
        default:
            return false
        }
    }
}
