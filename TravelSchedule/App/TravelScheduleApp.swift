//
//  TravelScheduleApp.swift
//  TravelSchedule
//
//  Created by Михаил Бобылев on 25.09.2025.
//

import SwiftUI

@main
struct TravelScheduleApp: App {
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
                    .onAppear {
                        Task {
                            await initializeServices()
                        }
                    }
            } else if let error = initializationError {
                Text("Ошибка инициализации: \(error.localizedDescription)")
                    .padding()
            } else {
                CoordinatorRootView()
                    .environmentObject(appCoordinator)
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
            let provider = try ServicesProvider(apikey: "deb309ef-bb5d-4fa4-bc10-72b1697f3b00")
            await MainActor.run {
                appCoordinator.servicesProvider = provider
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.showSplash = false
                    appCoordinator.start()
                }
            }
        } catch {
            await MainActor.run {
                self.initializationError = error
                self.showSplash = false
            }
        }
    }
}
