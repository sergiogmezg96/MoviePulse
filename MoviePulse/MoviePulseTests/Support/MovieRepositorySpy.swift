//
//  MovieRepositorySpy.swift
//  MoviePulseTests
//

@testable import MoviePulse

@MainActor
final class MovieRepositorySpy: MovieRepository {
    private(set) var savedFavorite: FavoriteMovieDomainModel?
    private(set) var deletedFavoriteID: Int?
    private(set) var savedMovieToMyList: MovieUIModel?
    private(set) var deletedMovieFromMyListID: Int?

    var favorites: [FavoriteMovieDomainModel] = []
    var myList: [MovieUIModel] = []

    func getMovies() async throws -> [MovieDomainModel] {
        []
    }

    func saveFavorite(_ movie: FavoriteMovieDomainModel) async throws {
        savedFavorite = movie
    }

    func deleteFavorite(_ id: Int) async throws {
        deletedFavoriteID = id
    }

    func getFavorites() async throws -> [FavoriteMovieDomainModel] {
        favorites
    }

    func getFavoriteById(by id: Int) async throws -> FavoriteMovieDomainModel? {
        favorites.first { $0.id == id }
    }

    func saveToMyList(_ movie: MovieUIModel) async throws {
        savedMovieToMyList = movie
    }

    func deleteFromMyList(_ id: Int) async throws {
        deletedMovieFromMyListID = id
    }

    func getMyList() async throws -> [MovieUIModel] {
        myList
    }

    func getMyListMovieById(by id: Int) async throws -> MovieUIModel? {
        myList.first { $0.id == id }
    }
}
