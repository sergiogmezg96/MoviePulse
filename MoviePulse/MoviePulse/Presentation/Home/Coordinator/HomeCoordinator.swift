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
public final class HomeCoordinator {
    @Binding private var navigationPath: [AnyHashable]
    private let delegate: HomeCoordinatorDelegate
    private let dependencyContainer: AppDependencyContainer
    private var homeStore: HomeStore?
    private var searchStore: SearchStore?
    
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
extension HomeCoordinator: GenreEffectHandling, MovieDetailEffectHandling, HomeEffectHandling, SearchEffectHandling {
    func openMovieDetail(movie: MovieUIModel) {
        navigationPath.append(Path.movieDetail(movie))
    }
    
    func openSeeGenre(genre: HomeGenreSectionUIModel) {
        navigationPath.append(Path.genre(genre))
    }

    func handle(_ effect: MovieDetailEffect) {
        switch effect {
        case .goBack:
            goBack()
        }
    }
    
    func handle(_ effect: HomeEffect) {
        switch effect {
        case .openMovieDetail(let movie):
            openMovieDetail(movie: movie)
        case .openGenre(let genre):
            openSeeGenre(genre: genre)
        }
    }

    func handle(_ effect: SearchEffect) {
        switch effect {
        case .dismiss:
            homeStore?.process(.dismissSearch)
        case .openMovieDetail(let movie):
            homeStore?.process(.dismissSearch)
            openMovieDetail(movie: movie)
        }
    }

    func handle(_ effect: GenreEffect) {
        switch effect {
        case .openMovieDetail(let movie):
            openMovieDetail(movie: movie)
        case .goBack:
            goBack()
        }
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
            store: makeHomeStore(),
            searchStore: makeSearchStore()
        )
    }

    @ViewBuilder
    func detailView(movie: MovieUIModel) -> some View {
        MovieDetailView(
            store: dependencyContainer.makeMovieDetailStore(
                movie: movie,
                effectHandler: self
            )
        )
    }

    @ViewBuilder
    func genreView(genre: HomeGenreSectionUIModel) -> some View {
        GenreView(store: dependencyContainer.makeGenreStore(
            genre: genre,
            effectHandler: self
        ))
    }

    private func makeHomeStore() -> HomeStore {
        if let cached = homeStore {
            return cached
        }

        let newStore = dependencyContainer.makeHomeStore(effectHandler: self)
        homeStore = newStore
        return newStore
    }

    private func makeSearchStore() -> SearchStore {
        if let cached = searchStore {
            return cached
        }

        let newStore = dependencyContainer.makeSearchStore(effectHandler: self)
        searchStore = newStore
        return newStore
    }
}
