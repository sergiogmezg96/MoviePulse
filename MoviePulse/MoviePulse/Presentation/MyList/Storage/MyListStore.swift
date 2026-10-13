//
//  MyListStore.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 03/10/2026.
//

import Observation
import MPLibrary

@MainActor
@Observable
final class MyListStore {
    private(set) var state: MyListState

    private let getFavoriteMoviesUseCase: GetFavoriteMoviesUseCase
    private let getMyListMoviesUseCase: GetMyListMoviesUseCase
    private let favoritesMapper: MyListFavoritesMapper
    private let reducer: MyListReducer
    private weak var effectHandler: (any MyListEffectHandling)?
    
    init(
        state: MyListState,
        reducer: MyListReducer = MyListReducer(),
        effectHandler: any MyListEffectHandling,
        getFavoriteMoviesUseCase: GetFavoriteMoviesUseCase,
        getMyListMoviesUseCase: GetMyListMoviesUseCase,
        favoritesMapper: MyListFavoritesMapper
    ) {
        self.state = state
        self.reducer = reducer
        self.effectHandler = effectHandler
        self.getFavoriteMoviesUseCase = getFavoriteMoviesUseCase
        self.getMyListMoviesUseCase = getMyListMoviesUseCase
        self.favoritesMapper = favoritesMapper
    }

    func process(_ intent: MyListIntent) {
        let transition = reducer.reduce(
            intent,
            state
        )

        state = transition.state

        if let effect = transition.effect {
            effectHandler?.handle(effect)
        }

        if let command = transition.command {
            execute(command)
        }
    }

    private func execute(_ command: MyListCommand) {
        switch command {
        case .loadMovies:
            loadMovies()
        }
    }
    
    private func loadMovies() {
        Task {
            do {
                async let favoriteMoviesRequest = getFavoriteMoviesUseCase.execute(request: ())
                async let moviesRequest = getMyListMoviesUseCase.execute(request: ())

                let favoriteMovies = try await favoriteMoviesRequest
                let movies = try await moviesRequest

                process(
                    .moviesLoaded(
                        favoriteMovies: favoritesMapper.map(favoriteMovies),
                        movies: movies
                    )
                )
            } catch {
                process(
                    .moviesFailed(
                        message: ApiErrorMapping.message(for: error)
                    )
                )
            }
        }
    }
}
