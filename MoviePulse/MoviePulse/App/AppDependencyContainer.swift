//
//  AppDependencyContainer.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 22/09/2026.
//

struct AppDependencyContainer {
    private let apiKey: String

    init(apiKey: String = MoviePulseConfiguration.tmdbApiKey) {
        self.apiKey = apiKey
    }
    
    // MARK: Repository
    func makeMovieRepository() -> MovieRepository {
        MovieRepositoryImpl(apiKey: apiKey)
    }

    // MARK: Use cases
    func makeGetMoviesUseCase() -> GetMoviesUseCase {
        GetMoviesUseCase(repository: makeMovieRepository())
    }

    // MARK: Stores
    @MainActor
    func makeHomeStore() -> HomeStore {
        HomeStore(
            state: .initial,
            getMoviesUseCase: makeGetMoviesUseCase(),
            moviesMapper: HomeMoviesMapper()
        )
    }
}
