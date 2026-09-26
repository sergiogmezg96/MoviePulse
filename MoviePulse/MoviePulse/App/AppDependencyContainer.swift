//
//  AppDependencyContainer.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 22/09/2026.
//

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

    // MARK: Stores
    @MainActor
    func makeHomeStore() -> HomeStore {
        HomeStore(
            state: .initial,
            getMoviesUseCase: makeGetMoviesUseCase(),
            saveFavoriteMovieUseCase: makeSaveFavoriteMovieUseCase(),
            moviesMapper: HomeMoviesMapper()
        )
    }
}
