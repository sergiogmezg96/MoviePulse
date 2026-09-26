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

    static let initial = MovieDetailState(
        status: .idle,
        movie: nil
    )
}
