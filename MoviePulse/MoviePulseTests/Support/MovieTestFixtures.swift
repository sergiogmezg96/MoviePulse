//
//  MovieTestFixtures.swift
//  MoviePulseTests
//

@testable import MoviePulse
import Foundation

enum MovieTestFixtures {
    static func favoriteMovie(id: Int = 1) -> FavoriteMovieDomainModel {
        FavoriteMovieDomainModel(
            id: id,
            title: "Favorite \(id)",
            subtitle: "Subtitle \(id)",
            overview: "Overview \(id)",
            releaseDate: "2026-01-01",
            voteAverage: 8.5,
            imageURL: URL(string: "https://example.com/poster-\(id).jpg"),
            backdropURL: URL(string: "https://example.com/backdrop-\(id).jpg")
        )
    }

    static func movie(id: Int = 1) -> MovieUIModel {
        MovieUIModel(
            id: id,
            title: "Movie \(id)",
            subtitle: "Subtitle \(id)",
            overview: "Overview \(id)",
            releaseDate: "2026-01-01",
            voteAverage: 8.5,
            imageURL: URL(string: "https://example.com/poster-\(id).jpg"),
            backdropURL: URL(string: "https://example.com/backdrop-\(id).jpg")
        )
    }
}
