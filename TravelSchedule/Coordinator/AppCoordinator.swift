//
//  AppCoordinator.swift
//  TravelSchedule
//
//  Created by Михаил Бобылев on 14.10.2025.
//

import UIKit
import SwiftUI

@MainActor
final class AppCoordinator: ObservableObject {
    private(set) var tripSelection = TripSelection()
    private(set) var filtersModel = FiltersModel()
    let navigationController = UINavigationController()
    var servicesProvider: ServicesProvider?

    func start() {
        guard let servicesProvider else { return }
        
        let tabBarController = UITabBarController()
        
        let homeView = HomeView(servicesProvider: servicesProvider, tripSelection: tripSelection)
            .environmentObject(self)
        let settingsView = SettingsView()
            .environmentObject(self)
        
        let homeNavController = UINavigationController(rootViewController: UIHostingController(rootView: homeView))
        let settingsNavController = UINavigationController(rootViewController: UIHostingController(rootView: settingsView))
        
        let homeIcon = UIImage(resource: .icSchedule)
        let settingsIcon = UIImage(resource: .icSettings)
        
        let homeIconSelected = homeIcon.withTintColor(.baseFont, renderingMode: .alwaysOriginal)
        let settingsIconSelected = settingsIcon.withTintColor(.baseFont, renderingMode: .alwaysOriginal)
        
        homeNavController.tabBarItem = UITabBarItem(title: nil,
                                                    image: homeIcon,
                                                    selectedImage: homeIconSelected)
        settingsNavController.tabBarItem = UITabBarItem(title: nil,
                                                        image: settingsIcon,
                                                        selectedImage: settingsIconSelected)
        
        tabBarController.viewControllers = [homeNavController, settingsNavController]
        
        let tabBar = tabBarController.tabBar
        tabBar.backgroundColor = UIColor(.baseBackground)
        tabBar.tintColor = .baseFont
        tabBar.unselectedItemTintColor = .grayUniversal
        tabBar.isTranslucent = false
        
        let topBorder = UIView(frame: CGRect(x: 0, y: 0, width: tabBar.bounds.width, height: 1))
        topBorder.backgroundColor = .black.withAlphaComponent(0.3)
        topBorder.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        tabBar.addSubview(topBorder)
        
        navigationController.setViewControllers([tabBarController], animated: false)
    }
    
    func showChoosingCityView(type: TripSelectionType) {
        guard let servicesProvider else { return }
        tripSelection.currentSelection = type
        let view = ChoosingCityView(servicesProvider: servicesProvider, tripSelection: tripSelection)
            .environmentObject(self)
        let viewController = UIHostingController(rootView: view)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showChoosingStationView(settlement: Components.Schemas.Settlement) {
        let view = ChoosingStationView(stations: settlement.stations ?? [], tripSelection: tripSelection)
            .environmentObject(self)
        let viewController = UIHostingController(rootView: view)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showScheduleView() {
        guard let servicesProvider else { return }
        let view = ScheduleView(servicesProvider: servicesProvider,
                                tripSelection: tripSelection,
                                filtersModel: filtersModel)
            .environmentObject(self)
        let viewController = UIHostingController(rootView: view)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showFiltersView() {
        let view = FiltersView(filtersModel: filtersModel)
            .environmentObject(self)
        let viewController = UIHostingController(rootView: view)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showCarrierDetailsView() {
        let view = CarrierDetailsView()
            .environmentObject(self)
        let viewController = UIHostingController(rootView: view)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func popViewController() {
        navigationController.popViewController(animated: true)
    }
    
    func popToRoot() {
        navigationController.popToRootViewController(animated: true)
    }
}
