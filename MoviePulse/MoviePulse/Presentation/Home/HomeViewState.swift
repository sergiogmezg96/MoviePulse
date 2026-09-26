//
//  HomeViewState.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 08/09/2026.
//

import Foundation

enum HomeViewStatus: Equatable {
    case idle
    case loading
    case loaded
    case failed(message: String)
}

struct HomeViewState: Equatable {
    let status: HomeViewStatus
    let featuredMovie: HomeMovieUIModel?
    let genreSections: [HomeGenreSectionUIModel]

    static let initial = HomeViewState(
        status: .idle,
        featuredMovie: nil,
        genreSections: []
    )
}
