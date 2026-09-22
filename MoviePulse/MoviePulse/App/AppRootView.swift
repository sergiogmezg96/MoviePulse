//
//  AppRootView.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 08/09/2026.
//

import SwiftUI

struct AppRootView: View {
    @State var homeStore = HomeStore()
    @State var selectedTab: AppRootTab = .home

    var body: some View {
        rootContent
    }
}

#Preview {
    AppRootView()
}
