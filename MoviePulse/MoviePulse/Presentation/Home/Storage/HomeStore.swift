//
//  HomeStore.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 08/09/2026.
//

import Observation
import MPLibrary

@MainActor
@Observable
final class HomeStore {
    private(set) var state: HomeViewState

    private let reducer: HomeReducer
    private weak var effectHandler: (any HomeEffectHandling)?
    private let getMoviesUseCase: GetMoviesUseCase
    private let saveMovieToMyListUseCase: SaveMovieToMyListUseCase
    private let deleteMovieFromMyListUseCase: DeleteMovieFromMyListUseCase
    private let getMyListMovieByIdUseCase: GetMyListMovieByIdUseCase
    private let moviesMapper: HomeMoviesMapper

    init(
        state: HomeViewState,
        reducer: HomeReducer = HomeReducer(),
        effectHandler: any HomeEffectHandling,
        getMoviesUseCase: GetMoviesUseCase,
        saveMovieToMyListUseCase: SaveMovieToMyListUseCase,
        deleteMovieFromMyListUseCase: DeleteMovieFromMyListUseCase,
        getMyListMovieByIdUseCase: GetMyListMovieByIdUseCase,
        moviesMapper: HomeMoviesMapper
    ) {
        self.state = state
        self.reducer = reducer
        self.effectHandler = effectHandler
        self.getMoviesUseCase = getMoviesUseCase
        self.saveMovieToMyListUseCase = saveMovieToMyListUseCase
        self.deleteMovieFromMyListUseCase = deleteMovieFromMyListUseCase
        self.getMyListMovieByIdUseCase = getMyListMovieByIdUseCase
        self.moviesMapper = moviesMapper
    }

    func process(_ intent: HomeIntent) {
        let transition = reducer.reduce(state: state, intent: intent)
        state = transition.state

        if let effect = transition.effect {
            effectHandler?.handle(effect)
        }

        if let command = transition.command {
            execute(command)
        }
    }

    private func execute(_ command: HomeCommand) {
        switch command {
        case .loadMovies:
            loadMovies()
        case .updateFeaturedMovieInMyList(let movie, let isCurrentlyInMyList):
            updateFeaturedMovieInMyList(movie, isCurrentlyInMyList: isCurrentlyInMyList)
        }
    }

    private func loadMovies() {
        Task {
            do {
                let movies = try await getMoviesUseCase.execute(request: ())
                let genreSections = moviesMapper.map(movies)

                guard !genreSections.isEmpty else {
                    process(.moviesFailed(message: "No hay peliculas disponibles."))
                    return
                }

                let featuredMovie = moviesMapper.mapFeaturedMovie(movies)
                let myListMovie: MovieUIModel?
                if let featuredMovie {
                    myListMovie = try await getMyListMovieByIdUseCase.execute(request: featuredMovie.id)
                } else {
                    myListMovie = nil
                }

                process(
                    .moviesLoaded(
                        featuredMovie: featuredMovie,
                        isFeaturedMovieInMyList: myListMovie != nil,
                        genreSections: genreSections
                    )
                )
            } catch {
                process(.moviesFailed(message: ApiErrorMapping.message(for: error)))
            }
        }
    }

    private func updateFeaturedMovieInMyList(
        _ movie: MovieUIModel,
        isCurrentlyInMyList: Bool
    ) {
        Task {
            if isCurrentlyInMyList {
                try? await deleteMovieFromMyListUseCase.execute(request: movie.id)
            } else {
                try? await saveMovieToMyListUseCase.execute(request: movie)
            }

            process(.featuredMovieMyListUpdated(isInMyList: !isCurrentlyInMyList))
        }
    }
}
