//
//  AppRootView.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 08/09/2026.
//

import SwiftUI

struct AppRootView: View {
    let dependencyContainer: AppDependencyContainer

    @State var selectedTab: AppRootTab = .home
    @State var navigationPath = [AnyHashable]()
    @State var homeCoordinator: HomeCoordinator?
    @State var myListCoordinator: MyListCoordinator?

    init(dependencyContainer: AppDependencyContainer = AppDependencyContainer()) {
        self.dependencyContainer = dependencyContainer
    }

    var body: some View {
        rootContent
    }
}

#Preview {
    AppRootView()
}
