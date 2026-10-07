//
//  AppDependencyContainer.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 22/09/2026.
//

import SwiftUI

final class AppDependencyContainer {
    private let apiKey: String
    private lazy var movieRepositoryImpl: MovieRepositoryImpl = {
        MovieRepositoryImpl(apiKey: apiKey)
    }()

    init(apiKey: String = MoviePulseConfiguration.tmdbApiKey) {
        self.apiKey = apiKey
    }
    
    // MARK: Use cases
    func makeGetMoviesUseCase() -> GetMoviesUseCase {
        GetMoviesUseCase(repository: movieRepositoryImpl)
    }

    func makeSaveFavoriteMovieUseCase() -> SaveFavoriteMovieUseCase {
        SaveFavoriteMovieUseCase(repository: movieRepositoryImpl)
    }

    func makeSaveMovieToMyListUseCase() -> SaveMovieToMyListUseCase {
        SaveMovieToMyListUseCase(repository: movieRepositoryImpl)
    }

    func makeDeleteFavoriteMovieUseCase() -> DeleteFavoriteMovieUseCase {
        DeleteFavoriteMovieUseCase(repository: movieRepositoryImpl)
    }

    func makeDeleteMovieFromMyListUseCase() -> DeleteMovieFromMyListUseCase {
        DeleteMovieFromMyListUseCase(repository: movieRepositoryImpl)
    }

    func makeGetFavoriteMovieByIdUseCase() -> GetFavoriteMovieByIdUseCase {
        GetFavoriteMovieByIdUseCase(repository: movieRepositoryImpl)
    }

    func makeGetFavoriteMoviesUseCase() -> GetFavoriteMoviesUseCase {
        GetFavoriteMoviesUseCase(repository: movieRepositoryImpl)
    }

    func makeGetMyListMovieByIdUseCase() -> GetMyListMovieByIdUseCase {
        GetMyListMovieByIdUseCase(repository: movieRepositoryImpl)
    }

    func makeGetMyListMoviesUseCase() -> GetMyListMoviesUseCase {
        GetMyListMoviesUseCase(repository: movieRepositoryImpl)
    }

    // MARK: Stores
    @MainActor
    func makeHomeStore(
        navigation: HomeCoordinatorNavigation
    ) -> HomeStore {
        HomeStore(
            state: .initial,
            getMoviesUseCase: makeGetMoviesUseCase(),
            saveMovieToMyListUseCase: makeSaveMovieToMyListUseCase(),
            deleteMovieFromMyListUseCase: makeDeleteMovieFromMyListUseCase(),
            getMyListMovieByIdUseCase: makeGetMyListMovieByIdUseCase(),
            moviesMapper: HomeMoviesMapper(),
            navigation: navigation
        )
    }

    @MainActor
    func makeMovieDetailStore(
        movie: MovieUIModel,
        navigation: MovieDetailNavigation
    ) -> MovieDetailStore {
        MovieDetailStore(
            state: .initial(movie: movie),
            saveFavoriteMovieUseCase: makeSaveFavoriteMovieUseCase(),
            deleteFavoriteMovieUseCase: makeDeleteFavoriteMovieUseCase(),
            getFavoriteMovieByIdUseCase: makeGetFavoriteMovieByIdUseCase(),
            saveMovieToMyListUseCase: makeSaveMovieToMyListUseCase(),
            deleteMovieFromMyListUseCase: makeDeleteMovieFromMyListUseCase(),
            getMyListMovieByIdUseCase: makeGetMyListMovieByIdUseCase(),
            navigation: navigation
        )
    }

    @MainActor
    func makeMyListStore(
        navigation: MyListNavigation
    ) -> MyListStore {
        MyListStore(
            state: .initial,
            getFavoriteMoviesUseCase: makeGetFavoriteMoviesUseCase(),
            getMyListMoviesUseCase: makeGetMyListMoviesUseCase(),
            favoritesMapper: MyListFavoritesMapper(),
            navigation: navigation
        )
    }

    @MainActor
    func makeHomeCoordinator(
        delegate: HomeCoordinatorDelegate,
        navigationPath: Binding<[AnyHashable]>
    ) -> HomeCoordinator {
        HomeCoordinator(
            delegate: delegate,
            navigationPath: navigationPath,
            dependencyContainer: self
        )
    }

    @MainActor
    func makeMyListCoordinator(
        delegate: MyListCoordinatorDelegate,
        navigationPath: Binding<[AnyHashable]>
    ) -> MyListCoordinator {
        MyListCoordinator(
            delegate: delegate,
            navigationPath: navigationPath,
            dependencyContainer: self
        )
    }
}
