//
//  MovieDetailStore.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 26/09/2026.
//

import Foundation
import Observation

@MainActor
@Observable
final class MovieDetailStore {
    private(set) var state: MovieDetailState
    
    private let saveFavoriteMovieUseCase: SaveFavoriteMovieUseCase
    private let deleteFavoriteMovieUseCase: DeleteFavoriteMovieUseCase
    private let getFavoriteMovieByIdUseCase: GetFavoriteMovieByIdUseCase
    private let saveMovieToMyListUseCase: SaveMovieToMyListUseCase
    private let deleteMovieFromMyListUseCase: DeleteMovieFromMyListUseCase
    private let getMyListMovieByIdUseCase: GetMyListMovieByIdUseCase
    private let onBackTap: () -> Void
    
    init(
        state: MovieDetailState,
        saveFavoriteMovieUseCase: SaveFavoriteMovieUseCase,
        deleteFavoriteMovieUseCase: DeleteFavoriteMovieUseCase,
        getFavoriteMovieByIdUseCase: GetFavoriteMovieByIdUseCase,
        saveMovieToMyListUseCase: SaveMovieToMyListUseCase,
        deleteMovieFromMyListUseCase: DeleteMovieFromMyListUseCase,
        getMyListMovieByIdUseCase: GetMyListMovieByIdUseCase,
        onBackTap: @escaping () -> Void
    ) {
        self.state = state
        self.saveFavoriteMovieUseCase = saveFavoriteMovieUseCase
        self.deleteFavoriteMovieUseCase = deleteFavoriteMovieUseCase
        self.getFavoriteMovieByIdUseCase = getFavoriteMovieByIdUseCase
        self.saveMovieToMyListUseCase = saveMovieToMyListUseCase
        self.deleteMovieFromMyListUseCase = deleteMovieFromMyListUseCase
        self.getMyListMovieByIdUseCase = getMyListMovieByIdUseCase
        self.onBackTap = onBackTap
    }
    
    func process(_ intent: MovieDetailIntent) {
        switch intent {
        case .viewDidAppear:
            loadView()
        case .rateMovie:
            //TODO: Do rate movie.
            break
        case .toggleFavorite:
            toggleFavorite()
        case .toggleMyList:
            toggleMyList()
        case .goBack:
            onBackTap()
        }
    }
    
    private func loadView() {
        guard state.status != .loading, state.status != .loaded else {
            return
        }

        state = MovieDetailState(
            status: .loading,
            movie: state.movie,
            isFavorite: state.isFavorite,
            isInMyList: state.isInMyList
        )

        guard let movie = state.movie else {
            state = MovieDetailState(
                status: .failed(message: "No se ha podido cargar la pelicula."),
                movie: nil,
                isFavorite: false,
                isInMyList: false
            )
            return
        }

        Task {
            let favoriteMovie = try? await getFavoriteMovieByIdUseCase.execute(request: movie.id)
            let myListMovie = try? await getMyListMovieByIdUseCase.execute(request: movie.id)

            state = MovieDetailState(
                status: .loaded,
                movie: movie,
                isFavorite: favoriteMovie != nil,
                isInMyList: myListMovie != nil
            )
        }
    }
    
    private func toggleFavorite() {
        guard let movie = state.movie else {
            return
        }

        state.isFavorite ? deleteFavoriteMovie(movie) : saveFavoriteMovie(movie)
    }

    private func toggleMyList() {
        guard let movie = state.movie else {
            return
        }

        state.isInMyList ? deleteMovieFromMyList(movie) : saveMovieToMyList(movie)
    }

    private func saveFavoriteMovie(_ movie: MovieUIModel) {
        Task {
            try? await saveFavoriteMovieUseCase.execute(
                request: mapFavoriteMovie(movie)
            )

            state = MovieDetailState(
                status: state.status,
                movie: state.movie,
                isFavorite: true,
                isInMyList: state.isInMyList
            )
        }
    }

    private func deleteFavoriteMovie(_ movie: MovieUIModel) {
        Task {
            try? await deleteFavoriteMovieUseCase.execute(request: movie.id)

            state = MovieDetailState(
                status: state.status,
                movie: state.movie,
                isFavorite: false,
                isInMyList: state.isInMyList
            )
        }
    }

    private func saveMovieToMyList(_ movie: MovieUIModel) {
        Task {
            try? await saveMovieToMyListUseCase.execute(
                request: movie
            )

            state = MovieDetailState(
                status: state.status,
                movie: state.movie,
                isFavorite: state.isFavorite,
                isInMyList: true
            )
        }
    }

    private func deleteMovieFromMyList(_ movie: MovieUIModel) {
        Task {
            try? await deleteMovieFromMyListUseCase.execute(request: movie.id)

            state = MovieDetailState(
                status: state.status,
                movie: state.movie,
                isFavorite: state.isFavorite,
                isInMyList: false
            )
        }
    }

    private func mapFavoriteMovie(_ movie: MovieUIModel) -> FavoriteMovieDomainModel {
        FavoriteMovieDomainModel(
            id: movie.id,
            title: movie.title,
            subtitle: movie.subtitle,
            overview: movie.overview,
            releaseDate: movie.releaseDate,
            voteAverage: movie.voteAverage,
            imageURL: movie.imageURL,
            backdropURL: movie.backdropURL
        )
    }
}
