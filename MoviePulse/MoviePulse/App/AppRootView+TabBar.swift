//
//  AppRootView+TabBar.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 20/09/2026.
//

import SwiftUI
import MPLibrary

enum AppRootTab: CaseIterable {
    case home
    case browse
    case myList
    case downloads
    
    var title: String {
        switch self {
        case .home:
            return String(localized: "tab_home")
        case .browse:
            return String(localized: "tab_browse")
        case .myList:
            return String(localized: "tab_my_list")
        case .downloads:
            return String(localized: "tab_downloads")
        }
    }
    
    var icon: String {
        switch self {
        case .home:
            return "house.fill"
        case .browse:
            return "movieclapper"
        case .myList:
            return "tv"
        case .downloads:
            return "arrow.down.to.line"
        }
    }
}

extension AppRootView {
    
    var rootContent: some View {
        NavigationStack(path: $navigationPath) {
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
                if let path = hashable as? HomeCoordinator.Path, let homeCoordinator {
                    homeCoordinator.buildPathDestination(for: path)
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
        switch selectedTab {
        case .home:
            homeCoordinatorContent
        case .myList:
            myListContent
        case .browse, .downloads:
            EmptyTabView(title: selectedTab.title)
        }
    }

    @ViewBuilder
    private var homeCoordinatorContent: some View {
        if let homeCoordinator {
            homeCoordinator.mainView
        } else {
            ProgressView()
                .onAppear {
                    guard homeCoordinator == nil else {
                        return
                    }

                    homeCoordinator = dependencyContainer.makeHomeCoordinator(
                        delegate: AppRootHomeCoordinatorDelegate(),
                        navigationPath: $navigationPath
                    )
                }
        }
    }

    @ViewBuilder
    private var myListContent: some View {
        if let myListStore {
            MyListView(store: myListStore)
        } else {
            ProgressView()
                .onAppear {
                    guard myListStore == nil else {
                        return
                    }

                    let coordinator = makeHomeCoordinatorIfNeeded()
                    myListStore = dependencyContainer.makeMyListStore(
                        navigation: coordinator
                    )
                }
        }
    }

    private func makeHomeCoordinatorIfNeeded() -> HomeCoordinator {
        if let homeCoordinator {
            return homeCoordinator
        }

        let coordinator = dependencyContainer.makeHomeCoordinator(
            delegate: AppRootHomeCoordinatorDelegate(),
            navigationPath: $navigationPath
        )
        homeCoordinator = coordinator
        return coordinator
    }
    
    private var tabBarItems: [MPTabBarItemConfig] {
        AppRootTab.allCases.map { tab in
            MPTabBarItemConfig(
                title: tab.title,
                icon: tab.icon,
                isSelected: selectedTab == tab,
                onTap: {
                    selectedTab = tab
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

@MainActor
private final class AppRootHomeCoordinatorDelegate: HomeCoordinatorDelegate {
    func finishHomeFlow() {}
}
