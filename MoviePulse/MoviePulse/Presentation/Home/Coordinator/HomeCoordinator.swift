//
//  HomeCoordinator.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 03/10/2026.
//

import Foundation
import SwiftUI

@MainActor
public protocol HomeCoordinatorDelegate {
    func finishHomeFlow()
}

@MainActor
protocol HomeCoordinatorNavigation {
    func openMovieDetail(movie: MovieUIModel)
    func openSeeGenre(genre: HomeGenreSectionUIModel)
    func closeHomeFlow()
    func goBack()
}

@MainActor
public final class HomeCoordinator {
    @Binding private var navigationPath: [AnyHashable]
    private let delegate: HomeCoordinatorDelegate
    private let dependencyContainer: AppDependencyContainer
    private var homeStore: HomeStore?
    
    init(
        delegate: HomeCoordinatorDelegate,
        navigationPath: Binding<[AnyHashable]>,
        dependencyContainer: AppDependencyContainer
    ) {
        self.delegate = delegate
        self._navigationPath = navigationPath
        self.dependencyContainer = dependencyContainer
    }
    
    enum Path: Hashable {
        case genre(HomeGenreSectionUIModel)
        case movieDetail(MovieUIModel)
    }

    @ViewBuilder
    func buildPathDestination(for path: Path) -> some View {
        switch path {
        case .genre(let genre):
            genreView(genre: genre)
                .toolbar(.hidden, for: .navigationBar)
        case .movieDetail(let movie):
            detailView(movie: movie)
                .toolbar(.hidden, for: .navigationBar)
        }
    }
}

// MARK: - Internal navigation
extension HomeCoordinator: HomeCoordinatorNavigation, GenreViewNavigation, MovieDetailNavigation {
    func openMovieDetail(movie: MovieUIModel) {
        navigationPath.append(Path.movieDetail(movie))
    }
    
    func openSeeGenre(genre: HomeGenreSectionUIModel) {
        navigationPath.append(Path.genre(genre))
    }

    func closeHomeFlow() {
        navigationPath.removeAll()
        delegate.finishHomeFlow()
    }
    
    func goBack() {
        guard !navigationPath.isEmpty else {
            closeHomeFlow()
            return
        }

        navigationPath.removeLast()
    }
}

// MARK: - Coordinator views
extension HomeCoordinator {

    @ViewBuilder
    var mainView: some View {
        HomeView(
            store: makeHomeStore()
        )
    }

    @ViewBuilder
    func detailView(movie: MovieUIModel) -> some View {
        MovieDetailView(
            store: dependencyContainer.makeMovieDetailStore(
                movie: movie,
                navigation: self
            )
        )
    }

    @ViewBuilder
    func genreView(genre: HomeGenreSectionUIModel) -> some View {
        GenreView(
            genre: genre,
            navigation: self
        )
    }

    private func makeHomeStore() -> HomeStore {
        if let cached = homeStore {
            return cached
        }

        let newStore = dependencyContainer.makeHomeStore(navigation: self)
        homeStore = newStore
        return newStore
    }
}
