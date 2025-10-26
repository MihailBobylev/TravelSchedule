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
    private var storyService = StoryService()
    private var homeNavigationController: UINavigationController?
    private var settingsNavigationController: UINavigationController?
    private var tabBarController: UITabBarController?
    var servicesProvider: ServicesProvider?
    
    func makeTabBarController() -> UITabBarController {
        guard let servicesProvider else { return UITabBarController() }
        
        let tabBarController = UITabBarController()
        
        let homeView = HomeView(servicesProvider: servicesProvider, tripSelection: tripSelection)
            .environmentObject(self)
            .environmentObject(storyService)
        let settingsView = SettingsView()
            .environmentObject(self)
        
        let homeNavController = UINavigationController(rootViewController: UIHostingController(rootView: homeView))
        homeNavController.setNavigationBarHidden(true, animated: false)
        homeNavigationController = homeNavController
        
        let settingsNavController = UINavigationController(rootViewController: UIHostingController(rootView: settingsView))
        settingsNavController.setNavigationBarHidden(true, animated: false)
        settingsNavigationController = settingsNavController
        
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
        
        self.tabBarController = tabBarController
        
        return tabBarController
    }

    func showChoosingCityView(type: TripSelectionType) {
        guard let servicesProvider else { return }
        
        tripSelection.currentSelection = type
        let view = ChoosingCityView(servicesProvider: servicesProvider, tripSelection: tripSelection)
            .environmentObject(self)
        let viewController = UIHostingController(rootView: view)
        viewController.hidesBottomBarWhenPushed = true
        homeNavigationController?.pushViewController(viewController, animated: true)
    }
    
    func showChoosingStationView(settlement: Components.Schemas.Settlement) {
        let view = ChoosingStationView(stations: settlement.stations ?? [], tripSelection: tripSelection)
            .environmentObject(self)
        let viewController = UIHostingController(rootView: view)
        homeNavigationController?.pushViewController(viewController, animated: true)
    }
    
    func showScheduleView() {
        guard let servicesProvider else { return }
        let view = ScheduleView(servicesProvider: servicesProvider,
                                tripSelection: tripSelection,
                                filtersModel: filtersModel)
            .environmentObject(self)
        let viewController = UIHostingController(rootView: view)
        viewController.hidesBottomBarWhenPushed = true
        homeNavigationController?.pushViewController(viewController, animated: true)
    }
    
    func showFiltersView() {
        let view = FiltersView(filtersModel: filtersModel)
            .environmentObject(self)
        let viewController = UIHostingController(rootView: view)
        homeNavigationController?.pushViewController(viewController, animated: true)
    }
    
    func showCarrierDetailsView(code: Int) {
        guard let servicesProvider else { return }
        let view = CarrierDetailsView(servicesProvider: servicesProvider, code: code)
        let viewController = UIHostingController(rootView: view)
        homeNavigationController?.pushViewController(viewController, animated: true)
    }
    
    func showUserAgreementView() {
        let view = UserAgreementView()
        let viewController = UIHostingController(rootView: view)
        viewController.hidesBottomBarWhenPushed = true
        settingsNavigationController?.pushViewController(viewController, animated: true)
    }
    
    func showStoryDetailsView(storiesPack: StoryPack) {
        let view = StoryDetailsView(storiesPack: storiesPack)
            .environmentObject(self)
            .environmentObject(storyService)
        let viewController = UIHostingController(rootView: view)
        viewController.modalPresentationStyle = .fullScreen
        homeNavigationController?.present(viewController, animated: true)
    }
    
    func dismiss() {
        homeNavigationController?.topViewController?.dismiss(animated: true, completion: nil)
    }
    
    func popViewController() {
        homeNavigationController?.popViewController(animated: true)
    }
    
    func popToRoot() {
        homeNavigationController?.popToRootViewController(animated: true)
    }
}
