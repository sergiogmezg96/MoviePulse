//
//  MyListState.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 03/10/2026.
//

enum MyListStatus: Equatable {
    case idle
    case loading
    case loaded
    case failed(message: String)
}

struct MyListState: Equatable {
    let status: MyListStatus
    let favoriteMovies: [MovieUIModel]
    let movies: [MovieUIModel]

    static let initial = MyListState(
        status: .idle,
        favoriteMovies: [],
        movies: []
    )
}
