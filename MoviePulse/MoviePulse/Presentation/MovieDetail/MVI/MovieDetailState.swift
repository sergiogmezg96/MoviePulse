//
//  MovieDetailState.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 26/09/2026.
//

enum MovieDetailStatus: Equatable {
    case idle
    case loading
    case loaded
    case failed(message: String)
}

struct MovieDetailState: Equatable {
    let status: MovieDetailStatus
    let movie: MovieUIModel?
    let isFavorite: Bool
    let isInMyList: Bool
    let operationErrorMessage: String?

    static let initial = MovieDetailState(
        status: .idle,
        movie: nil,
        isFavorite: false,
        isInMyList: false,
        operationErrorMessage: nil
    )

    static func initial(movie: MovieUIModel) -> MovieDetailState {
        MovieDetailState(
            status: .idle,
            movie: movie,
            isFavorite: false,
            isInMyList: false,
            operationErrorMessage: nil
        )
    }
}
