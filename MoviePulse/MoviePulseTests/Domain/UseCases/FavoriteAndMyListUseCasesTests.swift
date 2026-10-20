//
//  FavoriteAndMyListUseCasesTests.swift
//  MoviePulseTests
//

@testable import MoviePulse
import XCTest

@MainActor
final class FavoriteAndMyListUseCasesTests: XCTestCase {
    private var repository: MovieRepositorySpy!

    override func setUp() {
        super.setUp()
        repository = MovieRepositorySpy()
    }

    override func tearDown() {
        repository = nil
        super.tearDown()
    }

    func testSaveFavoriteDelegatesMovieToRepository() async throws {
        let movie = MovieTestFixtures.favoriteMovie()

        try await SaveFavoriteMovieUseCase(repository: repository).execute(request: movie)

        XCTAssertEqual(repository.savedFavorite, movie)
    }

    func testDeleteFavoriteDelegatesIdentifierToRepository() async throws {
        let movieID = 7

        try await DeleteFavoriteMovieUseCase(repository: repository).execute(request: movieID)

        XCTAssertEqual(repository.deletedFavoriteID, movieID)
    }

    func testGetFavoritesReturnsRepositoryMovies() async throws {
        let expectedMovies = [MovieTestFixtures.favoriteMovie()]
        repository.favorites = expectedMovies

        let movies = try await GetFavoriteMoviesUseCase(repository: repository).execute(request: ())

        XCTAssertEqual(movies, expectedMovies)
    }

    func testGetFavoriteByIdReturnsRepositoryMovie() async throws {
        let expectedMovie = MovieTestFixtures.favoriteMovie(id: 7)
        repository.favorites = [expectedMovie]

        let movie = try await GetFavoriteMovieByIdUseCase(repository: repository).execute(request: expectedMovie.id)

        XCTAssertEqual(movie, expectedMovie)
    }

    func testSaveToMyListDelegatesMovieToRepository() async throws {
        let movie = MovieTestFixtures.movie()

        try await SaveMovieToMyListUseCase(repository: repository).execute(request: movie)

        XCTAssertEqual(repository.savedMovieToMyList, movie)
    }

    func testDeleteFromMyListDelegatesIdentifierToRepository() async throws {
        let movieID = 7

        try await DeleteMovieFromMyListUseCase(repository: repository).execute(request: movieID)

        XCTAssertEqual(repository.deletedMovieFromMyListID, movieID)
    }

    func testGetMyListReturnsRepositoryMovies() async throws {
        let expectedMovies = [MovieTestFixtures.movie()]
        repository.myList = expectedMovies

        let movies = try await GetMyListMoviesUseCase(repository: repository).execute(request: ())

        XCTAssertEqual(movies, expectedMovies)
    }

    func testGetMyListMovieByIdReturnsRepositoryMovie() async throws {
        let expectedMovie = MovieTestFixtures.movie(id: 7)
        repository.myList = [expectedMovie]

        let movie = try await GetMyListMovieByIdUseCase(repository: repository).execute(request: expectedMovie.id)

        XCTAssertEqual(movie, expectedMovie)
    }
}
