//
//  MovieRepositoryImpl.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 08/09/2026.
//

import Foundation

struct MovieRepositoryImpl: MovieRepository {
    func getMovies() async throws -> [any MovieDomainModel] {
        return []
    }
}
