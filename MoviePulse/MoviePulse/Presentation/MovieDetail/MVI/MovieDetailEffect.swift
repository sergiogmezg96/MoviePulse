//
//  MovieDetailEffect.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 16/10/2026.
//

import Foundation

enum MovieDetailEffect: Equatable {
    case goBack
}

@MainActor
protocol MovieDetailEffectHandling: AnyObject {
    func handle(_ effect: MovieDetailEffect)
}
