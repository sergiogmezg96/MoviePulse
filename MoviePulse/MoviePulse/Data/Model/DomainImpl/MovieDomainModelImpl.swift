//
//  MovieDomainModelImpl.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 08/09/2026.
//

import Foundation

struct MovieDomainModelImpl: MovieDomainModel {
    let adult: Bool
    let backdropPath: String?
    let genreIds: [Int]
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let title: String
    let overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
}
