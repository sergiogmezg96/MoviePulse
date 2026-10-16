//
//  GenreStore.swift
//  MoviePulse
//
//  Created by sergio.gomez.local on 29/09/2026.
//

import Observation

@MainActor
@Observable
final class GenreStore {
    private(set) var state: GenreState

    private let reducer: GenreReducer
    private weak var effectHandler: (any GenreEffectHandling)?

    init(
        state: GenreState,
        reducer: GenreReducer = GenreReducer(),
        effectHandler: any GenreEffectHandling
    ) {
        self.state = state
        self.reducer = reducer
        self.effectHandler = effectHandler
    }

    func process(_ intent: GenreIntent) {
        let transition = reducer.reduce(state: state, intent: intent)
        state = transition.state

        if let effect = transition.effect {
            effectHandler?.handle(effect)
        }
    }
}
