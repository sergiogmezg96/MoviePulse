//
//  MovieRepository.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 08/09/2026.
//

import Foundation

protocol MovieRepository {
    func getMovies() async throws -> [MovieDomainModel]
    func saveFavorite(_ movie: FavoriteMovieDomainModel) async throws
    func deleteFavorite(_ id: Int) async throws
    func getFavorites() async throws -> [FavoriteMovieDomainModel]
    func getFavoriteById(by id: Int) async throws -> FavoriteMovieDomainModel?
    func saveToMyList(_ movie: MovieUIModel) async throws
    func deleteFromMyList(_ id: Int) async throws
    func getMyList() async throws -> [MovieUIModel]
    func getMyListMovieById(by id: Int) async throws -> MovieUIModel?
}
