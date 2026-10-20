//
//  MovieRepositoryImplTests.swift
//  MoviePulseTests
//

@testable import MoviePulse
import XCTest

@MainActor
final class MovieRepositoryImplTests: XCTestCase {
    private var userDefaults: UserDefaults!
    private var repository: MovieRepositoryImpl!

    override func setUp() {
        super.setUp()

        userDefaults = UserDefaults(suiteName: "MovieRepositoryImplTests")!
        userDefaults.removePersistentDomain(forName: "MovieRepositoryImplTests")
        repository = MovieRepositoryImpl(apiKey: "test-api-key", userDefaults: userDefaults)
    }

    override func tearDown() {
        userDefaults.removePersistentDomain(forName: "MovieRepositoryImplTests")
        repository = nil
        userDefaults = nil

        super.tearDown()
    }

    func testSaveFavoritePersistsMovie() async throws {
        let movie = MovieTestFixtures.favoriteMovie(id: 1)

        try await repository.saveFavorite(movie)

        let favorites = try await repository.getFavorites()
        let savedMovie = try await repository.getFavoriteById(by: movie.id)

        XCTAssertEqual(favorites, [movie])
        XCTAssertEqual(savedMovie, movie)
    }

    func testGetFavoritesReturnsEmptyCollectionWhenNothingWasPersisted() async throws {
        let favorites = try await repository.getFavorites()

        XCTAssertTrue(favorites.isEmpty)
    }

    func testGetFavoriteByIdReturnsNilWhenMovieIsNotPersisted() async throws {
        let movie = try await repository.getFavoriteById(by: 999)

        XCTAssertNil(movie)
    }

    func testSaveFavoriteDoesNotPersistDuplicates() async throws {
        let movie = MovieTestFixtures.favoriteMovie(id: 1)

        try await repository.saveFavorite(movie)
        try await repository.saveFavorite(movie)

        let favorites = try await repository.getFavorites()

        XCTAssertEqual(favorites, [movie])
    }

    func testDeleteFavoriteRemovesOnlyMatchingMovie() async throws {
        let retainedMovie = MovieTestFixtures.favoriteMovie(id: 1)
        let deletedMovie = MovieTestFixtures.favoriteMovie(id: 2)
        try await repository.saveFavorite(retainedMovie)
        try await repository.saveFavorite(deletedMovie)

        try await repository.deleteFavorite(deletedMovie.id)

        let favorites = try await repository.getFavorites()
        let deletedFavorite = try await repository.getFavoriteById(by: deletedMovie.id)

        XCTAssertEqual(favorites, [retainedMovie])
        XCTAssertNil(deletedFavorite)
    }

    func testDeleteFavoriteDoesNotModifyPersistedMoviesWhenIdentifierDoesNotExist() async throws {
        let movie = MovieTestFixtures.favoriteMovie()
        try await repository.saveFavorite(movie)

        try await repository.deleteFavorite(999)

        let favorites = try await repository.getFavorites()
        XCTAssertEqual(favorites, [movie])
    }

    func testSaveToMyListPersistsMovie() async throws {
        let movie = MovieTestFixtures.movie(id: 1)

        try await repository.saveToMyList(movie)

        let myList = try await repository.getMyList()
        let savedMovie = try await repository.getMyListMovieById(by: movie.id)

        XCTAssertEqual(myList, [movie])
        XCTAssertEqual(savedMovie, movie)
    }

    func testGetMyListReturnsEmptyCollectionWhenNothingWasPersisted() async throws {
        let myList = try await repository.getMyList()

        XCTAssertTrue(myList.isEmpty)
    }

    func testGetMyListMovieByIdReturnsNilWhenMovieIsNotPersisted() async throws {
        let movie = try await repository.getMyListMovieById(by: 999)

        XCTAssertNil(movie)
    }

    func testSaveToMyListDoesNotPersistDuplicates() async throws {
        let movie = MovieTestFixtures.movie(id: 1)

        try await repository.saveToMyList(movie)
        try await repository.saveToMyList(movie)

        let myList = try await repository.getMyList()

        XCTAssertEqual(myList, [movie])
    }

    func testDeleteFromMyListRemovesOnlyMatchingMovie() async throws {
        let retainedMovie = MovieTestFixtures.movie(id: 1)
        let deletedMovie = MovieTestFixtures.movie(id: 2)
        try await repository.saveToMyList(retainedMovie)
        try await repository.saveToMyList(deletedMovie)

        try await repository.deleteFromMyList(deletedMovie.id)

        let myList = try await repository.getMyList()
        let deletedMovieFromList = try await repository.getMyListMovieById(by: deletedMovie.id)

        XCTAssertEqual(myList, [retainedMovie])
        XCTAssertNil(deletedMovieFromList)
    }

    func testDeleteFromMyListDoesNotModifyPersistedMoviesWhenIdentifierDoesNotExist() async throws {
        let movie = MovieTestFixtures.movie()
        try await repository.saveToMyList(movie)

        try await repository.deleteFromMyList(999)

        let myList = try await repository.getMyList()
        XCTAssertEqual(myList, [movie])
    }

    func testGetFavoritesThrowsWhenPersistedDataIsInvalid() async {
        userDefaults.set(Data("invalid".utf8), forKey: "moviepulse.favorite.movies")

        do {
            _ = try await repository.getFavorites()
            XCTFail("Expected an error when decoding invalid favorite movies data")
        } catch {
            XCTAssertTrue(error is DecodingError)
        }
    }

    func testGetMyListThrowsWhenPersistedDataIsInvalid() async {
        userDefaults.set(Data("invalid".utf8), forKey: "moviepulse.my-list.movies")

        do {
            _ = try await repository.getMyList()
            XCTFail("Expected an error when decoding invalid my list data")
        } catch {
            XCTAssertTrue(error is DecodingError)
        }
    }

}
