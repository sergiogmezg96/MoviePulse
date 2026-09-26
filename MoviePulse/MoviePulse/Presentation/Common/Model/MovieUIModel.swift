//
//  MovieUIModel.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 26/09/2026.
//

import Foundation

struct MovieUIModel: Equatable, Hashable, Identifiable {
    let id: Int
    let title: String
    let subtitle: String
    let overview: String
    let releaseDate: String
    let voteAverage: Double
    let imageURL: URL?
    let backdropURL: URL?
}
