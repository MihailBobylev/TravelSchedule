//
//  TravelScheduleApp.swift
//  TravelSchedule
//
//  Created by Михаил Бобылев on 25.09.2025.
//

import SwiftUI

@main
struct TravelScheduleApp: App {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @StateObject private var appCoordinator = AppCoordinator()
    @State private var showSplash = true
    @State private var initializationError: Error? = nil
    
    init() {
        setupNavigationAppearance()
    }
    
    var body: some Scene {
        WindowGroup {
            if showSplash {
                SplashView()
                    .task {
                        await initializeServices()
                    }
            } else if let error = initializationError {
                Text("Ошибка инициализации: \(error.localizedDescription)")
                    .padding()
            } else {
                CoordinatorRootView()
                    .environmentObject(appCoordinator)
                    .preferredColorScheme(isDarkMode ? .dark : .light)
                    .ignoresSafeArea(.all)
            }
        }
    }
}

private extension TravelScheduleApp {
    func setupNavigationAppearance() {
        let backImage = UIImage(resource: .arrowLeft).withTintColor(.baseFont, renderingMode: .alwaysOriginal)
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemBackground
        appearance.shadowColor = .clear
        
        appearance.setBackIndicatorImage(backImage, transitionMaskImage: backImage)
        appearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
    }
    
    func initializeServices() async {
        do {
            let provider = try ServicesProvider(apikey: "")
            try await Task.sleep(nanoseconds: 1_000_000_000)

            await MainActor.run {
                appCoordinator.servicesProvider = provider
                showSplash = false
            }
        } catch {
            await MainActor.run {
                initializationError = error
                showSplash = false
            }
        }
    }
}
