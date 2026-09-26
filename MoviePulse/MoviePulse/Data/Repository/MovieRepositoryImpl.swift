//
//  MovieRepositoryImpl.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 08/09/2026.
//

import Foundation
import MPLibrary

struct MovieRepositoryImpl: MovieRepository {
    private let apiKey: String
    private let userDefaults: UserDefaults

    init(
        apiKey: String,
        userDefaults: UserDefaults = .standard
    ) {
        self.apiKey = apiKey
        self.userDefaults = userDefaults
    }

    func getMovies() async throws -> [MovieDomainModel] {
        let endpoint = ApiNetwork.makeEndpoint(
            path: ApiPath.Movie.popular,
            apiKey: apiKey,
            queryItems: ApiNetwork.defaultMovieQueryItems()
        )

        let request = ApiRequest(
            url: endpoint,
            method: .get
        )

        let response: MoviesResponseModel = try await ApiNetworkExecutor.execute(
            request,
            type: MoviesResponseModel.self
        )

        return response.results.map(\.domainModel)
    }

    func save(_ movie: FavoriteMovieDomainModel) async throws {
        var movies = try await getFavorites()

        guard !movies.contains(where: { $0.id == movie.id }) else {
            return
        }

        movies.append(movie)
        try saveFavorites(movies)
    }

    func delete(_ id: Int) async throws {
        let favorites = try await getFavorites()
        let movies = favorites.filter { $0.id != id }
        try saveFavorites(movies)
    }

    func getFavorites() async throws -> [FavoriteMovieDomainModel] {
        guard let data = userDefaults.data(forKey: Constants.favoriteMoviesKey) else {
            return []
        }

        return try JSONDecoder().decode([FavoriteMovieDomainModel].self, from: data)
    }

    func getFavoriteById(by id: Int) async throws -> FavoriteMovieDomainModel? {
        let favorites = try await getFavorites()
        return favorites.first { $0.id == id }
    }

    private func saveFavorites(_ movies: [FavoriteMovieDomainModel]) throws {
        let data = try JSONEncoder().encode(movies)
        userDefaults.set(data, forKey: Constants.favoriteMoviesKey)
    }

    private enum Constants {
        static let favoriteMoviesKey = "moviepulse.favorite.movies"
    }
}
