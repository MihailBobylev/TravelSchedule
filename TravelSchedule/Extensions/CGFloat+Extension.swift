//
//  CGFloat+Extension.swift
//  TravelSchedule
//
//  Created by Михаил Бобылев on 11.10.2025.
//

import UIKit

private enum DeviceMetrics {
    static let baseHeight: CGFloat = 812
    static let baseWidth: CGFloat = 375
    
    @MainActor
    static let screenHeight: CGFloat = UIScreen.main.bounds.height
    
    @MainActor
    static let screenWidth: CGFloat = UIScreen.main.bounds.width
}

@MainActor
extension Int {
    var dfs: CGFloat { CGFloat(self).dfs }
    var dvs: CGFloat { CGFloat(self).dvs }
    var dhs: CGFloat { CGFloat(self).dhs }
}

@MainActor
extension Double {
    var dfs: CGFloat { CGFloat(self).dfs }
    var dvs: CGFloat { CGFloat(self).dvs }
    var dhs: CGFloat { CGFloat(self).dhs }
}

@MainActor
extension CGFloat {
    
    /// Dynamic Font Size scaled based on screen height.
    var dfs: CGFloat {
        Swift.max(10, self * DeviceMetrics.screenHeight / DeviceMetrics.baseHeight)
    }

    /// Dynamic Vertical Size scaled based on screen height.
    var dvs: CGFloat {
        self * DeviceMetrics.screenHeight / DeviceMetrics.baseHeight
    }

    /// Dynamic Horizontal Size scaled based on screen width.
    var dhs: CGFloat {
        self * DeviceMetrics.screenWidth / DeviceMetrics.baseWidth
    }
}
