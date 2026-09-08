//
//  HomeStore.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 08/09/2026.
//

import Observation

@MainActor
@Observable
final class HomeStore {
    private(set) var state: HomeViewState

    init(state: HomeViewState = .initial) {
        self.state = state
    }

    func process(_ intent: HomeIntent) {
        switch intent {
        case .appear:
            break
        }
    }
}
