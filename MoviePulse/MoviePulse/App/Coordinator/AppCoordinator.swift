//
//  AppCoordinator.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 07/10/2026.
//

import SwiftUI
import Foundation
import Combine

@MainActor
final class AppCoordinator: ObservableObject {

    @Published var selectedTab: AppConstants.Tab = .home
    @Published var navigationPath = [AnyHashable]()

    private let dependencyContainer: AppDependencyContainer

    lazy var navigationBinding = Binding<[AnyHashable]>(
        get: { self.navigationPath },
        set: { [weak self] newValue in
            self?.navigationPath = newValue
        }
    )
    lazy var homeCoordinator: HomeCoordinator = dependencyContainer.makeHomeCoordinator(
        delegate: self,
        navigationPath: navigationBinding
    )
    lazy var myListCoordinator: MyListCoordinator = dependencyContainer.makeMyListCoordinator(
        delegate: self,
        navigationPath: navigationBinding
    )

    init(dependencyContainer: AppDependencyContainer) {
        self.dependencyContainer = dependencyContainer
    }

    var availableTabs: [AppConstants.Tab] {
        [
            .home,
            .myList
            // .browse,
            // .downloads
        ]
    }
}

extension AppCoordinator: HomeCoordinatorDelegate, MyListCoordinatorDelegate {
    func finishHomeFlow() {}

    func finishMyListFlow() {}
}
