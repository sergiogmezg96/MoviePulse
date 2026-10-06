//
//  MyListCoordinator.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 06/10/2026.
//

import SwiftUI
import Foundation

@MainActor
public protocol MyListCoordinatorDelegate {
    func finishMyListFlow()
}

@MainActor
public final class MyListCoordinator {

    @Binding private var navigationPath: [AnyHashable]
    private let delegate: MyListCoordinatorDelegate
    private let dependencyContainer: AppDependencyContainer
    private var myListStore: MyListStore?

    init(
        delegate: MyListCoordinatorDelegate,
        navigationPath: Binding<[AnyHashable]>,
        dependencyContainer: AppDependencyContainer
    ) {
        self.delegate = delegate
        self._navigationPath = navigationPath
        self.dependencyContainer = dependencyContainer
    }

    enum Path: Hashable {
        case movieDetail(MovieUIModel)
    }

    @ViewBuilder
    func buildPathDestination(for path: Path) -> some View {
        switch path {
        case .movieDetail(let movie):
            movieDetailView(movie: movie)
                .toolbar(.hidden, for: .navigationBar)
        }
    }
}

// MARK: - Internal navigation
extension MyListCoordinator: MyListNavigation, MovieDetailNavigation {
    func openMovieDetail(movie: MovieUIModel) {
        navigationPath.append(Path.movieDetail(movie))
    }

    func goBack() {
        guard !navigationPath.isEmpty else {
            closeMyListFlow()
            return
        }

        navigationPath.removeLast()
    }

    private func closeMyListFlow() {
        navigationPath.removeAll()
        delegate.finishMyListFlow()
    }
}

// MARK: - Coordinator views
extension MyListCoordinator {

    @ViewBuilder
    var mainView: some View {
        MyListView(store: makeMyListStore())
    }

    @ViewBuilder
    func movieDetailView(movie: MovieUIModel) -> some View {
        MovieDetailView(
            store: dependencyContainer.makeMovieDetailStore(
                movie: movie,
                navigation: self
            )
        )
    }

    private func makeMyListStore() -> MyListStore {
        if let cached = myListStore {
            return cached
        }

        let newStore = dependencyContainer.makeMyListStore(navigation: self)
        myListStore = newStore
        return newStore
    }
}
