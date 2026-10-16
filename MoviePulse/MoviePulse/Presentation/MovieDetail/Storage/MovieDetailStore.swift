//
//  MovieDetailStore.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 26/09/2026.
//

import Foundation
import Observation
import MPLibrary

@MainActor
@Observable
final class MovieDetailStore {
    private(set) var state: MovieDetailState

    private let reducer: MovieDetailReducer
    private weak var effectHandler: (any MovieDetailEffectHandling)?
    private let saveFavoriteMovieUseCase: SaveFavoriteMovieUseCase
    private let deleteFavoriteMovieUseCase: DeleteFavoriteMovieUseCase
    private let getFavoriteMovieByIdUseCase: GetFavoriteMovieByIdUseCase
    private let saveMovieToMyListUseCase: SaveMovieToMyListUseCase
    private let deleteMovieFromMyListUseCase: DeleteMovieFromMyListUseCase
    private let getMyListMovieByIdUseCase: GetMyListMovieByIdUseCase

    init(
        state: MovieDetailState,
        reducer: MovieDetailReducer = MovieDetailReducer(),
        effectHandler: any MovieDetailEffectHandling,
        saveFavoriteMovieUseCase: SaveFavoriteMovieUseCase,
        deleteFavoriteMovieUseCase: DeleteFavoriteMovieUseCase,
        getFavoriteMovieByIdUseCase: GetFavoriteMovieByIdUseCase,
        saveMovieToMyListUseCase: SaveMovieToMyListUseCase,
        deleteMovieFromMyListUseCase: DeleteMovieFromMyListUseCase,
        getMyListMovieByIdUseCase: GetMyListMovieByIdUseCase
    ) {
        self.state = state
        self.reducer = reducer
        self.effectHandler = effectHandler
        self.saveFavoriteMovieUseCase = saveFavoriteMovieUseCase
        self.deleteFavoriteMovieUseCase = deleteFavoriteMovieUseCase
        self.getFavoriteMovieByIdUseCase = getFavoriteMovieByIdUseCase
        self.saveMovieToMyListUseCase = saveMovieToMyListUseCase
        self.deleteMovieFromMyListUseCase = deleteMovieFromMyListUseCase
        self.getMyListMovieByIdUseCase = getMyListMovieByIdUseCase
    }

    func process(_ intent: MovieDetailIntent) {
        let transition = reducer.reduce(state: state, intent: intent)
        state = transition.state

        if let effect = transition.effect {
            effectHandler?.handle(effect)
        }

        if let command = transition.command {
            execute(command)
        }
    }

    private func execute(_ command: MovieDetailCommand) {
        switch command {
        case .loadMovieStatus(let movie):
            loadMovieStatus(movie)
        case .updateFavorite(let movie, let isCurrentlyFavorite):
            updateFavorite(movie, isCurrentlyFavorite: isCurrentlyFavorite)
        case .updateMyList(let movie, let isCurrentlyInMyList):
            updateMyList(movie, isCurrentlyInMyList: isCurrentlyInMyList)
        }
    }

    private func loadMovieStatus(_ movie: MovieUIModel) {
        Task {
            do {
                async let favoriteMovie = getFavoriteMovieByIdUseCase.execute(request: movie.id)
                async let myListMovie = getMyListMovieByIdUseCase.execute(request: movie.id)

                let favorite = try await favoriteMovie
                let myList = try await myListMovie

                process(
                    .movieStatusLoaded(
                        isFavorite: favorite != nil,
                        isInMyList: myList != nil
                    )
                )
            } catch {
                process(.movieStatusFailed(message: ApiErrorMapping.message(for: error)))
            }
        }
    }

    private func updateFavorite(
        _ movie: MovieUIModel,
        isCurrentlyFavorite: Bool
    ) {
        Task {
            do {
                if isCurrentlyFavorite {
                    try await deleteFavoriteMovieUseCase.execute(request: movie.id)
                } else {
                    try await saveFavoriteMovieUseCase.execute(request: mapFavoriteMovie(movie))
                }

                process(.favoriteUpdated(isFavorite: !isCurrentlyFavorite))
            } catch {
                process(.operationFailed(message: ApiErrorMapping.message(for: error)))
            }
        }
    }

    private func updateMyList(
        _ movie: MovieUIModel,
        isCurrentlyInMyList: Bool
    ) {
        Task {
            do {
                if isCurrentlyInMyList {
                    try await deleteMovieFromMyListUseCase.execute(request: movie.id)
                } else {
                    try await saveMovieToMyListUseCase.execute(request: movie)
                }

                process(.myListUpdated(isInMyList: !isCurrentlyInMyList))
            } catch {
                process(.operationFailed(message: ApiErrorMapping.message(for: error)))
            }
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
