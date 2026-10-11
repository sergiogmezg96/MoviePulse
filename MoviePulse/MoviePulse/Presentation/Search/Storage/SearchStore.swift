//
//  SearchStore.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 11/10/2026.
//

import Foundation
import Observation
import MPLibrary

@MainActor
@Observable
final class SearchStore {
    private(set) var state: SearchViewState

    private let getMoviesUseCase: GetMoviesUseCase
    private let moviesMapper: HomeMoviesMapper
    private weak var effectHandler: (any SearchEffectHandling)?

    init(
        state: SearchViewState,
        getMoviesUseCase: GetMoviesUseCase,
        moviesMapper: HomeMoviesMapper,
        effectHandler: any SearchEffectHandling
    ) {
        self.state = state
        self.getMoviesUseCase = getMoviesUseCase
        self.moviesMapper = moviesMapper
        self.effectHandler = effectHandler
    }

    var filteredMovies: [MovieUIModel] {
        let query = state.query.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !query.isEmpty else {
            return state.movies
        }

        return state.movies.filter { movie in
            movie.title.localizedCaseInsensitiveContains(query)
        }
    }

    func process(_ intent: SearchIntent) {
        switch intent {
        case .viewDidAppear:
            loadMovies()
        case .queryChanged(let query):
            state.query = query
        case .dismiss:
            effectHandler?.handle(.dismiss)
        case .selectMovie(let movie):
            effectHandler?.handle(.openMovieDetail(movie))
        }
    }

    private func loadMovies() {
        guard state.status == .idle else {
            return
        }

        state.status = .loading

        Task {
            do {
                let movies = try await getMoviesUseCase.execute(request: ())
                state.movies = moviesMapper.mapMovies(movies)
                state.status = .loaded
            } catch {
                state.status = .failed(message: ApiErrorMapping.message(for: error))
            }
        }
    }
}
