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

    func makeGetMyListMovieByIdUseCase() -> GetMyListMovieByIdUseCase {
        GetMyListMovieByIdUseCase(repository: movieRepositoryImpl)
    }

    // MARK: Stores
    @MainActor
    func makeHomeStore() -> HomeStore {
        HomeStore(
            state: .initial,
            getMoviesUseCase: makeGetMoviesUseCase(),
            saveMovieToMyListUseCase: makeSaveMovieToMyListUseCase(),
            moviesMapper: HomeMoviesMapper()
        )
    }

    @MainActor
    func makeMovieDetailStore(
        movie: MovieUIModel,
        onBackTap: @escaping () -> Void
    ) -> MovieDetailStore {
        MovieDetailStore(
            state: .initial(movie: movie),
            saveFavoriteMovieUseCase: makeSaveFavoriteMovieUseCase(),
            deleteFavoriteMovieUseCase: makeDeleteFavoriteMovieUseCase(),
            getFavoriteMovieByIdUseCase: makeGetFavoriteMovieByIdUseCase(),
            saveMovieToMyListUseCase: makeSaveMovieToMyListUseCase(),
            deleteMovieFromMyListUseCase: makeDeleteMovieFromMyListUseCase(),
            getMyListMovieByIdUseCase: makeGetMyListMovieByIdUseCase(),
            onBackTap: onBackTap
        )
    }
}
