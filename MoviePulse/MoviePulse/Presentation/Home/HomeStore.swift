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
    private let moviesMapper: HomeMoviesMapper

    init(
        state: HomeViewState,
        getMoviesUseCase: GetMoviesUseCase,
        moviesMapper: HomeMoviesMapper
    ) {
        self.state = state
        self.getMoviesUseCase = getMoviesUseCase
        self.moviesMapper = moviesMapper
    }

    func process(_ intent: HomeIntent) {
        switch intent {
        case .viewDidAppear:
            loadMovies()
        case .selectGenre:
            //TODO: Do see genre movies.
            break
        case .addMovieToMyList:
            //TODO: Do add to my list.
            break
        case .selectMovie:
            //TODO: Do see movie details.
            break
        case .selectProfile:
            //TODO: Do view profile.
            break
        case .submitSearch:
            //TODO: Do search movie.
            break
        }
    }

    private func loadMovies() {
        guard state.status != .loading else {
            return
        }

        state = HomeViewState(
            status: .loading,
            featuredMovie: state.featuredMovie,
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
                        genreSections: []
                    )
                    return
                }

                state = HomeViewState(
                    status: .loaded,
                    featuredMovie: moviesMapper.mapFeaturedMovie(movies),
                    genreSections: genreSections
                )
            } catch {
                state = HomeViewState(
                    status: .failed(message: makeErrorMessage(from: error)),
                    featuredMovie: nil,
                    genreSections: []
                )
            }
        }
    }

    private func makeErrorMessage(from error: Error) -> String {
        guard let apiError = error as? ApiError else {
            return "No se han podido cargar las peliculas."
        }

        switch apiError {
        case .unauthorized:
            return "API key de TMDb no valida."
        case .forbidden:
            return "TMDb ha rechazado la peticion."
        case .dataParsingError:
            return "No se ha podido leer la respuesta de peliculas."
        case .malformedURL:
            return "La URL de peliculas no es valida."
        case .networkError:
            return "No hay conexion con TMDb."
        case .serviceUnavailable:
            return "TMDb no esta disponible ahora mismo."
        case .serverError:
            return "TMDb ha devuelto un error de servidor."
        case .invalidResponse, .unknownError:
            return "No se han podido cargar las peliculas."
        }
    }
}
