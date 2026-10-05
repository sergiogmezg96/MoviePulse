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

    private let getMyListMoviesUseCase: GetMyListMoviesUseCase
    private let navigation: MyListNavigation

    init(
        state: MyListState,
        getMyListMoviesUseCase: GetMyListMoviesUseCase,
        navigation: MyListNavigation
    ) {
        self.state = state
        self.getMyListMoviesUseCase = getMyListMoviesUseCase
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
            movies: state.movies
        )

        Task {
            do {
                let movies = try await getMyListMoviesUseCase.execute(request: ())
                state = MyListState(
                    status: .loaded,
                    movies: movies
                )
            } catch {
                state = MyListState(
                    status: .failed(message: ApiErrorMapping.message(for: error)),
                    movies: []
                )
            }
        }
    }
}
