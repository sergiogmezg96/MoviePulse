//
//  MoviePulseApp.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 08/09/2026.
//

import SwiftUI

@main
struct MoviePulseApp: App {
    @StateObject private var appCoordinator: AppCoordinator

    init() {
        let dependencyContainer = AppDependencyContainer()
        _appCoordinator = StateObject(
            wrappedValue: AppCoordinator(dependencyContainer: dependencyContainer)
        )
    }

    var body: some Scene {
        WindowGroup {
            AppRootView(appCoordinator: appCoordinator)
        }
    }
}
