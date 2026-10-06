//
//  MyListStore.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 03/10/2026.
//

import Observation
import MPLibrary

@MainActor
protocol MyListNavigation {
    func openMovieDetail(movie: MovieUIModel)
}

@MainActor
@Observable
final class MyListStore {
    private(set) var state: MyListState

    private let getFavoriteMoviesUseCase: GetFavoriteMoviesUseCase
    private let getMyListMoviesUseCase: GetMyListMoviesUseCase
    private let favoritesMapper: MyListFavoritesMapper
    private let navigation: MyListNavigation

    init(
        state: MyListState,
        getFavoriteMoviesUseCase: GetFavoriteMoviesUseCase,
        getMyListMoviesUseCase: GetMyListMoviesUseCase,
        favoritesMapper: MyListFavoritesMapper,
        navigation: MyListNavigation
    ) {
        self.state = state
        self.getFavoriteMoviesUseCase = getFavoriteMoviesUseCase
        self.getMyListMoviesUseCase = getMyListMoviesUseCase
        self.favoritesMapper = favoritesMapper
        self.navigation = navigation
    }

    func process(_ intent: MyListIntent) {
        switch intent {
        case .viewDidAppear:
            loadMovies()
        case .selectMovie(let movie):
            navigation.openMovieDetail(movie: movie)
        }
    }

    private func loadMovies() {
        state = MyListState(
            status: .loading,
            favoriteMovies: state.favoriteMovies,
            movies: state.movies
        )

        Task {
            do {
                async let favoriteMovies = getFavoriteMoviesUseCase.execute(request: ())
                async let movies = getMyListMoviesUseCase.execute(request: ())

                state = MyListState(
                    status: .loaded,
                    favoriteMovies: favoritesMapper.map(try await favoriteMovies),
                    movies: try await movies
                )
            } catch {
                state = MyListState(
                    status: .failed(message: ApiErrorMapping.message(for: error)),
                    favoriteMovies: [],
                    movies: []
                )
            }
        }
    }
}
