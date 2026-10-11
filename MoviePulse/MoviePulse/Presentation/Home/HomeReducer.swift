//
//  HomeReducer.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 08/10/2026.
//

struct HomeReducer {
    struct Transition {
        let state: HomeViewState
        let effect: HomeEffect?
        let command: HomeCommand?
    }

    func reduce(state: HomeViewState, intent: HomeIntent) -> Transition {
        switch intent {
        case .viewDidAppear:
            guard state.status != .loading else {
                return Transition(state: state, effect: nil, command: nil)
            }

            return Transition(
                state: HomeViewState(
                    status: .loading,
                    featuredMovie: state.featuredMovie,
                    isFeaturedMovieInMyList: state.isFeaturedMovieInMyList,
                    isSearchPresented: state.isSearchPresented,
                    genreSections: state.genreSections
                ),
                effect: nil,
                command: .loadMovies
            )
        case .openSearch:
            return Transition(
                state: HomeViewState(
                    status: state.status,
                    featuredMovie: state.featuredMovie,
                    isFeaturedMovieInMyList: state.isFeaturedMovieInMyList,
                    isSearchPresented: true,
                    genreSections: state.genreSections
                ),
                effect: nil,
                command: nil
            )
        case .dismissSearch:
            return Transition(
                state: HomeViewState(
                    status: state.status,
                    featuredMovie: state.featuredMovie,
                    isFeaturedMovieInMyList: state.isFeaturedMovieInMyList,
                    isSearchPresented: false,
                    genreSections: state.genreSections
                ),
                effect: nil,
                command: nil
            )
        case .selectGenre(let genre):
            return Transition(state: state, effect: .openGenre(genre), command: nil)
        case .selectMovie(let movie):
            return Transition(state: state, effect: .openMovieDetail(movie), command: nil)
        case .toggleFeaturedMovieInMyList(let movie):
            return Transition(
                state: state,
                effect: nil,
                command: .updateFeaturedMovieInMyList(
                    movie,
                    isCurrentlyInMyList: state.isFeaturedMovieInMyList
                )
            )
        case .moviesLoaded(let featuredMovie, let isFeaturedMovieInMyList, let genreSections):
            return Transition(
                state: HomeViewState(
                    status: .loaded,
                    featuredMovie: featuredMovie,
                    isFeaturedMovieInMyList: isFeaturedMovieInMyList,
                    isSearchPresented: state.isSearchPresented,
                    genreSections: genreSections
                ),
                effect: nil,
                command: nil
            )
        case .moviesFailed(let message):
            return Transition(
                state: HomeViewState(
                    status: .failed(message: message),
                    featuredMovie: nil,
                    isFeaturedMovieInMyList: false,
                    isSearchPresented: state.isSearchPresented,
                    genreSections: []
                ),
                effect: nil,
                command: nil
            )
        case .featuredMovieMyListUpdated(let isInMyList):
            return Transition(
                state: HomeViewState(
                    status: state.status,
                    featuredMovie: state.featuredMovie,
                    isFeaturedMovieInMyList: isInMyList,
                    isSearchPresented: state.isSearchPresented,
                    genreSections: state.genreSections
                ),
                effect: nil,
                command: nil
            )
        }
    }
}
