//
//  AppRootView.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 08/09/2026.
//

import SwiftUI

struct AppRootView: View {
    private let dependencyContainer: AppDependencyContainer

    @State var homeStore: HomeStore
    @State var selectedTab: AppRootTab = .home
    @State var navigationPath = NavigationPath()

    init(dependencyContainer: AppDependencyContainer = AppDependencyContainer()) {
        self.dependencyContainer = dependencyContainer
        _homeStore = State(initialValue: dependencyContainer.makeHomeStore())
    }

    var body: some View {
        rootContent
    }
}

enum AppRoute: Hashable {
    case movieDetail(MovieUIModel)
}

#Preview {
    AppRootView()
}
