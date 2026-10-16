//
//  AppRootView.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 08/09/2026.
//

import SwiftUI

struct AppRootView: View {
    @ObservedObject var appCoordinator: AppCoordinator

    var body: some View {
        rootContent
    }
}

#Preview {
    AppRootView(
        appCoordinator: AppCoordinator(
            dependencyContainer: AppDependencyContainer()
        )
    )
}
