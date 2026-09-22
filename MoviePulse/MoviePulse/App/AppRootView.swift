//
//  AppRootView.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 08/09/2026.
//

import SwiftUI

struct AppRootView: View {
    @State var homeStore = AppRootView.makeHomeStore()
    @State var selectedTab: AppRootTab = .home
    @State var navigationPath = NavigationPath()

    var body: some View {
        rootContent
    }
}

private extension AppRootView {
    static func makeHomeStore() -> HomeStore {
        return HomeStore(
            getMoviesUseCase: GetMoviesUseCase(
                repository: MovieRepositoryImpl(
                    apiKey: MoviePulseConfiguration.tmdbApiKey
                )
            )
        )
    }
}

enum AppRoute: Hashable {
    case movieDetail
}

#Preview {
    AppRootView()
}
