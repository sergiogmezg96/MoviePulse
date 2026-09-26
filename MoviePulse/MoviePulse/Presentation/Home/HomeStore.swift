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

    private let getMoviesUseCase: GetMoviesUseCase
    private let moviesMapper: HomeMoviesMapper

    init(
        state: HomeViewState,
        getMoviesUseCase: GetMoviesUseCase,
        moviesMapper: HomeMoviesMapper
    ) {
        self.state = state
        self.getMoviesUseCase = getMoviesUseCase
        self.moviesMapper = moviesMapper
    }

    func process(_ intent: HomeIntent) {
        switch intent {
        case .viewDidAppear:
            loadMovies()
        case .selectGenre:
            //TODO: Do see genre movies.
            break
        case .addMovieToMyList:
            //TODO: Do add to my list.
            break
        case .selectMovie:
            //TODO: Do see movie details.
            break
        case .selectProfile:
            //TODO: Do view profile.
            break
        case .submitSearch:
            //TODO: Do search movie.
            break
        }
    }

    private func loadMovies() {
        guard state.status != .loading else {
            return
        }

        state = HomeViewState(
            status: .loading,
            featuredMovie: state.featuredMovie,
            genreSections: state.genreSections
        )

        Task {
            do {
                let movies = try await getMoviesUseCase.execute(request: ())
                let genreSections = moviesMapper.map(movies)

                guard !genreSections.isEmpty else {
                    state = HomeViewState(
                        status: .failed(message: "No hay peliculas disponibles."),
                        featuredMovie: nil,
                        genreSections: []
                    )
                    return
                }

                state = HomeViewState(
                    status: .loaded,
                    featuredMovie: moviesMapper.mapFeaturedMovie(movies),
                    genreSections: genreSections
                )
            } catch {
                state = HomeViewState(
                    status: .failed(message: ApiErrorMapping.message(for: error)),
                    featuredMovie: nil,
                    genreSections: []
                )
            }
        }
    }
}
