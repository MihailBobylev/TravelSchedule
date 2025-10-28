//
//  CoordinatorRootView.swift
//  TravelSchedule
//
//  Created by Михаил Бобылев on 14.10.2025.
//

import SwiftUI
import UIKit

struct CoordinatorRootView: UIViewControllerRepresentable {
    @EnvironmentObject var appCoordinator: AppCoordinator

    func makeUIViewController(context: Context) -> UITabBarController {
        let tabBarController = appCoordinator.makeTabBarController()
        return tabBarController
    }

    func updateUIViewController(_ uiViewController: UITabBarController, context: Context) {}
}
