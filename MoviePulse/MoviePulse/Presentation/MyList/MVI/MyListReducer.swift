//
//  MyListReducer.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 13/10/2026.
//

import Foundation

struct MyListReducer {
    struct Transition {
        let state: MyListState
        let effect: MyListEffect?
        let command: MyListCommand?
    }
    
    func reduce(_ intent: MyListIntent,_ state: MyListState) -> Transition {
        
        switch intent {
        case .viewDidAppear:
            guard state.status != .loading else {
                return Transition(state: state, effect: nil, command: nil)
            }
            
            return Transition(
                state: .init(
                    status: .loading,
                    favoriteMovies: state.favoriteMovies,
                    movies: state.movies,
                    selectedFilter: state.selectedFilter
                ),
                effect: nil,
                command: .loadMovies
            )
        case .selectFilter(let filter):
            return Transition(
                state: MyListState(
                    status: state.status,
                    favoriteMovies: state.favoriteMovies,
                    movies: state.movies,
                    selectedFilter: filter
                ),
                effect: nil,
                command: nil
            )
            
        case .selectMovie(let movie):
            return Transition(
                state: state,
                effect: .openMovieDetail(movie),
                command: nil
            )
            
        case .moviesLoaded(let favoriteMovies, let movies):
            return Transition(
                state: MyListState(
                    status: .loaded,
                    favoriteMovies: favoriteMovies,
                    movies: movies,
                    selectedFilter: state.selectedFilter
                ),
                effect: nil,
                command: nil
            )
            
        case .moviesFailed(let message):
            return Transition(
                state: MyListState(
                    status: .failed(message: message),
                    favoriteMovies: [],
                    movies: [],
                    selectedFilter: state.selectedFilter
                ),
                effect: nil,
                command: nil
            )
        }
    }
}
