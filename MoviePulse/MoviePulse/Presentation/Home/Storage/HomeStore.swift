//
//  HomeStore.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 08/09/2026.
//

import Observation
import MPLibrary

@MainActor
@Observable
final class HomeStore {
    private(set) var state: HomeViewState

    private let getMoviesUseCase: GetMoviesUseCase
    private let saveMovieToMyListUseCase: SaveMovieToMyListUseCase
    private let deleteMovieFromMyListUseCase: DeleteMovieFromMyListUseCase
    private let getMyListMovieByIdUseCase: GetMyListMovieByIdUseCase
    private let moviesMapper: HomeMoviesMapper
    private let navigation: HomeCoordinatorNavigation

    init(
        state: HomeViewState,
        getMoviesUseCase: GetMoviesUseCase,
        saveMovieToMyListUseCase: SaveMovieToMyListUseCase,
        deleteMovieFromMyListUseCase: DeleteMovieFromMyListUseCase,
        getMyListMovieByIdUseCase: GetMyListMovieByIdUseCase,
        moviesMapper: HomeMoviesMapper,
        navigation: HomeCoordinatorNavigation
    ) {
        self.state = state
        self.getMoviesUseCase = getMoviesUseCase
        self.saveMovieToMyListUseCase = saveMovieToMyListUseCase
        self.deleteMovieFromMyListUseCase = deleteMovieFromMyListUseCase
        self.getMyListMovieByIdUseCase = getMyListMovieByIdUseCase
        self.moviesMapper = moviesMapper
        self.navigation = navigation
    }

    func process(_ intent: HomeIntent) {
        switch intent {
        case .viewDidAppear:
            loadMovies()
        case .selectGenre(let genre):
            navigation.openSeeGenre(genre: genre)
        case .toggleFeaturedMovieInMyList(let movie):
            toggleFeaturedMovieInMyList(movie)
        case .selectMovie(let movie):
            navigation.openMovieDetail(movie: movie)
        // case .selectProfile:
        //     break
        // case .submitSearch:
        //     break
        }
    }

    private func loadMovies() {
        guard state.status != .loading else {
            return
        }

        state = HomeViewState(
            status: .loading,
            featuredMovie: state.featuredMovie,
            isFeaturedMovieInMyList: state.isFeaturedMovieInMyList,
            genreSections: state.genreSections
        )

        Task {
            do {
                let movies = try await getMoviesUseCase.execute(request: ())
                let genreSections = moviesMapper.map(movies)

                guard !genreSections.isEmpty else {
                    state = HomeViewState(
                        status: .failed(message: "No hay peliculas disponibles."),
                        featuredMovie: nil,
                        isFeaturedMovieInMyList: false,
                        genreSections: []
                    )
                    return
                }

                let featuredMovie = moviesMapper.mapFeaturedMovie(movies)
                let myListMovie: MovieUIModel?
                if let featuredMovie {
                    myListMovie = try? await getMyListMovieByIdUseCase.execute(request: featuredMovie.id)
                } else {
                    myListMovie = nil
                }

                state = HomeViewState(
                    status: .loaded,
                    featuredMovie: featuredMovie,
                    isFeaturedMovieInMyList: myListMovie != nil,
                    genreSections: genreSections
                )
            } catch {
                state = HomeViewState(
                    status: .failed(message: ApiErrorMapping.message(for: error)),
                    featuredMovie: nil,
                    isFeaturedMovieInMyList: false,
                    genreSections: []
                )
            }
        }
    }

    private func toggleFeaturedMovieInMyList(_ movie: MovieUIModel) {
        state.isFeaturedMovieInMyList ? deleteMovieFromMyList(movie) : saveMovieToMyList(movie)
    }

    private func saveMovieToMyList(_ movie: MovieUIModel) {
        Task {
            try? await saveMovieToMyListUseCase.execute(
                request: movie
            )

            state = HomeViewState(
                status: state.status,
                featuredMovie: state.featuredMovie,
                isFeaturedMovieInMyList: true,
                genreSections: state.genreSections
            )
        }
    }

    private func deleteMovieFromMyList(_ movie: MovieUIModel) {
        Task {
            try? await deleteMovieFromMyListUseCase.execute(request: movie.id)

            state = HomeViewState(
                status: state.status,
                featuredMovie: state.featuredMovie,
                isFeaturedMovieInMyList: false,
                genreSections: state.genreSections
            )
        }
    }
}
