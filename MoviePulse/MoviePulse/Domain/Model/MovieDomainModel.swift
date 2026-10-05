//
//  MovieDomainModel.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 08/09/2026.
//

import Foundation

public protocol MovieDomainModel: Codable {
    var adult: Bool { get }
    var backdropPath: String? { get }
    var genreIds: [Int] { get }
    var id: Int { get }
    var originalLanguage: String { get }
    var originalTitle: String { get }
    var title: String { get }
    var overview: String { get }
    var popularity: Double { get }
    var posterPath: String? { get }
    var releaseDate: String { get }
    var video: Bool { get }
    var voteAverage: Double { get }
    var voteCount: Int { get }
}
