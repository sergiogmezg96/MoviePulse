//
//  FavoriteMovieDomainModel.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 26/09/2026.
//

import Foundation

public struct FavoriteMovieDomainModel: Codable, Equatable, Hashable, Identifiable {
    public let id: Int
    public let title: String
    public let subtitle: String
    public let overview: String
    public let releaseDate: String
    public let voteAverage: Double
    public let imageURL: URL?
    public let backdropURL: URL?

    public init(
        id: Int,
        title: String,
        subtitle: String,
        overview: String,
        releaseDate: String,
        voteAverage: Double,
        imageURL: URL?,
        backdropURL: URL?
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.overview = overview
        self.releaseDate = releaseDate
        self.voteAverage = voteAverage
        self.imageURL = imageURL
        self.backdropURL = backdropURL
    }
}
