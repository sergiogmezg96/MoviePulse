//
//  MovieRepository.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 08/09/2026.
//

import Foundation

public protocol MovieRepository {
    func getMovies() async throws -> [MovieDomainModel]
    func save(_ movie: FavoriteMovieDomainModel) async throws
    func delete(_ id: Int) async throws
    func getFavorites() async throws -> [FavoriteMovieDomainModel]
    func getFavoriteById(by id: Int) async throws -> FavoriteMovieDomainModel?
}
