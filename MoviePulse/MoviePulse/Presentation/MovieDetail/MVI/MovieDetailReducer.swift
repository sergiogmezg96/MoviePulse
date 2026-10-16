//
//  MovieDetailReducer.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 16/10/2026.
//

import Foundation
import MPLibrary

struct MovieDetailReducer {
    struct Transition {
        let state: MovieDetailState
        let effect: MovieDetailEffect?
        let command: MovieDetailCommand?
    }
    
    func reduce(state: MovieDetailState, intent: MovieDetailIntent) -> Transition {
        
        switch intent {
        case .viewDidAppear:
            guard state.status != .loading, state.status != .loaded else {
                return Transition(state: state, effect: nil, command: nil)
            }
            guard let movie = state.movie else {
                return Transition(
                    state: makeState(
                        from: state,
                        status: .failed(message: "No se ha podido cargar la pelicula.")
                    ),
                    effect: nil,
                    command: nil
                )
            }
            
            return Transition(
                state: makeState(
                    from: state,
                    status: .loading,
                    clearOperationError: true
                ),
                effect: nil,
                command: .loadMovieStatus(movie)
            )
            
        case .toggleFavorite:
            guard let movie = state.movie else {
                return Transition(state: state, effect: nil, command: nil)
            }
            
            return Transition(
                state: state,
                effect: nil,
                command: .updateFavorite(
                    movie,
                    isCurrentlyFavorite: state.isFavorite
                )
            )
            
        case .toggleMyList:
            guard let movie = state.movie else {
                return Transition(state: state, effect: nil, command: nil)
            }
            
            return Transition(
                state: state,
                effect: nil,
                command: .updateMyList(
                    movie,
                    isCurrentlyInMyList: state.isInMyList
                )
            )
            
        case .goBack:
            return Transition(state: state, effect: .goBack, command: nil)
            
        case .movieStatusLoaded(isFavorite: let isFavorite, isInMyList: let isInMyList):
            return Transition(
                state: makeState(
                    from: state,
                    status: .loaded,
                    isFavorite: isFavorite,
                    isInMyList: isInMyList,
                    clearOperationError: true
                ),
                effect: nil,
                command: nil
            )
            
        case .movieStatusFailed(let message):
            return Transition(
                state: makeState(from: state, status: .failed(message: message)),
                effect: nil,
                command: nil
            )
            
        case .favoriteUpdated(let isFavorite):
            return Transition(
                state: makeState(from: state, isFavorite: isFavorite),
                effect: nil,
                command: nil
            )
            
        case .myListUpdated(let isInMyList):
            return Transition(
                state: makeState(from: state, isInMyList: isInMyList),
                effect: nil,
                command: nil
            )
            
        case .operationFailed(let message):
            return Transition(
                state: makeState(from: state, operationErrorMessage: message),
                effect: nil,
                command: nil
            )
            
        case .dismissOperationError:
            return Transition(
                state: makeState(from: state, clearOperationError: true),
                effect: nil,
                command: nil
            )
            
        }
    }
}

private func makeState(
    from state: MovieDetailState,
    status: MovieDetailStatus? = nil,
    isFavorite: Bool? = nil,
    isInMyList: Bool? = nil,
    operationErrorMessage: String? = nil,
    clearOperationError: Bool = false
) -> MovieDetailState {
    MovieDetailState(
        status: status ?? state.status,
        movie: state.movie,
        isFavorite: isFavorite ?? state.isFavorite,
        isInMyList: isInMyList ?? state.isInMyList,
        operationErrorMessage: clearOperationError
        ? nil
        : operationErrorMessage ?? state.operationErrorMessage
    )
}

