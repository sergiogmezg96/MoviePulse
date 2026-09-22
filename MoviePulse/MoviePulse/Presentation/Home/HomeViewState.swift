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
    let featuredMovie: HomeMovieViewData?
    let genreSections: [HomeGenreSectionViewData]

    static let initial = HomeViewState(
        status: .idle,
        featuredMovie: nil,
        genreSections: []
    )
}

struct HomeGenreSectionViewData: Equatable, Identifiable {
    let id: Int
    let title: String
    let movies: [HomeMovieViewData]
}

struct HomeMovieViewData: Equatable, Identifiable {
    let id: Int
    let title: String
    let subtitle: String
    let overview: String
    let releaseDate: String
    let imageURL: URL?
    let backdropURL: URL?
}
