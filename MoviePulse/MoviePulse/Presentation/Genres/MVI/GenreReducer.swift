//
//  GenreReducer.swift
//  MoviePulse
//
//  Created by sergio.gomez.local on 29/09/2026.
//

struct GenreReducer {
    struct Transition {
        let state: GenreState
        let effect: GenreEffect?
    }

    func reduce(state: GenreState, intent: GenreIntent) -> Transition {
        switch intent {
        case .selectFilter(let filter):
            return Transition(
                state: GenreState(genre: state.genre, selectedFilter: filter),
                effect: nil
            )
        case .selectMovie(let movie):
            return Transition(state: state, effect: .openMovieDetail(movie))
        case .goBack:
            return Transition(state: state, effect: .goBack)
        }
    }
}
