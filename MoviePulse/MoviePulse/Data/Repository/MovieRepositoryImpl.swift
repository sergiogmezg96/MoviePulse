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

    func saveFavorite(_ movie: FavoriteMovieDomainModel) async throws {
        var movies = try await getFavorites()

        guard !movies.contains(where: { $0.id == movie.id }) else {
            return
        }

        movies.append(movie)
        try save(movies, key: Constants.favoriteMoviesKey)
    }

    func deleteFavorite(_ id: Int) async throws {
        let favorites = try await getFavorites()
        let movies = favorites.filter { $0.id != id }
        try save(movies, key: Constants.favoriteMoviesKey)
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

    func saveToMyList(_ movie: MovieUIModel) async throws {
        var movies = try await getMyList()

        guard !movies.contains(where: { $0.id == movie.id }) else {
            return
        }

        movies.append(movie)
        try save(movies, key: Constants.myListMoviesKey)
    }

    func deleteFromMyList(_ id: Int) async throws {
        let myList = try await getMyList()
        let movies = myList.filter { $0.id != id }
        try save(movies, key: Constants.myListMoviesKey)
    }

    func getMyList() async throws -> [MovieUIModel] {
        guard let data = userDefaults.data(forKey: Constants.myListMoviesKey) else {
            return []
        }

        return try JSONDecoder().decode([MovieUIModel].self, from: data)
    }

    func getMyListMovieById(by id: Int) async throws -> MovieUIModel? {
        let myList = try await getMyList()
        return myList.first { $0.id == id }
    }

    private func save<T: Encodable>(_ movies: T, key: String) throws {
        let data = try JSONEncoder().encode(movies)
        userDefaults.set(data, forKey: key)
    }

    private enum Constants {
        static let favoriteMoviesKey = "moviepulse.favorite.movies"
        static let myListMoviesKey = "moviepulse.my-list.movies"
    }
}
