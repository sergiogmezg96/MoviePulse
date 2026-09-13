//
//  AppRootView.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 08/09/2026.
//

import SwiftUI

struct AppRootView: View {
    @State private var homeStore = HomeStore()

    var body: some View {
        HomeView(store: homeStore)
    }
}

#Preview {
    AppRootView()
}
