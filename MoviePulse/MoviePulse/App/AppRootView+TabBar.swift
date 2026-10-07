//
//  AppRootView+TabBar.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 20/09/2026.
//

import SwiftUI
import MPLibrary

extension AppRootView {
    
    var rootContent: some View {
        NavigationStack(path: appCoordinator.navigationBinding) {
            VStack(spacing: CustomSize.size0) {
                selectedTabContent
                
                MPTabBar(
                    config: MPTabBarConfig(
                        tabBarItems: tabBarItems
                    )
                )
            }
            .background(AppColor.background.opacity(0.95))
            .navigationDestination(for: AnyHashable.self) { hashable in
                if let path = hashable as? HomeCoordinator.Path {
                    appCoordinator.homeCoordinator.buildPathDestination(for: path)
                } else if let path = hashable as? MyListCoordinator.Path {
                    appCoordinator.myListCoordinator.buildPathDestination(for: path)
                } else {
                    Text("")
                        .onAppear {
                            assertionFailure("Unexpected navigation destination received.")
                        }
                }
            }
        }
    }
    
    @ViewBuilder
    private var selectedTabContent: some View {
        switch appCoordinator.selectedTab {
        case .home:
            homeCoordinatorContent
        case .myList:
            myListContent
        case .browse, .downloads:
            EmptyTabView(title: appCoordinator.selectedTab.title)
        }
    }

    @ViewBuilder
    private var homeCoordinatorContent: some View {
        appCoordinator.homeCoordinator.mainView
    }

    @ViewBuilder
    private var myListContent: some View {
        appCoordinator.myListCoordinator.mainView
    }
    
    private var tabBarItems: [MPTabBarItemConfig] {
        appCoordinator.availableTabs.map { tab in
            MPTabBarItemConfig(
                title: tab.title,
                icon: tab.icon,
                isSelected: appCoordinator.selectedTab == tab,
                onTap: {
                    appCoordinator.selectedTab = tab
                }
            )
        }
    }

}

private struct EmptyTabView: View {
    let title: String
    
    var body: some View {
        VStack {
            Spacer()
            
            Text(title)
                .font(FontSize.title2Bold)
                .foregroundColor(AppColor.textPrimary)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(AppColor.background.opacity(0.95))
    }
}
