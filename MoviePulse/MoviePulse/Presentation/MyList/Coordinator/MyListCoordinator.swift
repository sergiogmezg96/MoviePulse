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
extension MyListCoordinator: MyListEffectHandling, MovieDetailEffectHandling {
    func handle(_ effect: MyListEffect) {
        switch effect {
        case .openMovieDetail(let movie):
            openMovieDetail(movie: movie)
        }
    }

    func handle(_ effect: MovieDetailEffect) {
        switch effect {
        case .goBack:
            goBack()
        }
    }
    
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
                effectHandler: self
            )
        )
    }

    private func makeMyListStore() -> MyListStore {
        if let cached = myListStore {
            return cached
        }

        let newStore = dependencyContainer.makeMyListStore(effectHandler: self)
        myListStore = newStore
        return newStore
    }
}
