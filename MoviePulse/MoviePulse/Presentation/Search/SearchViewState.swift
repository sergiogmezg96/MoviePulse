//
//  SearchViewState.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 11/10/2026.
//

struct SearchViewState {
    enum Status: Equatable {
        case idle
        case loading
        case loaded
        case failed(message: String)
    }

    var status: Status
    var query: String
    var movies: [MovieUIModel]

    static let initial = SearchViewState(
        status: .idle,
        query: "",
        movies: []
    )
}
