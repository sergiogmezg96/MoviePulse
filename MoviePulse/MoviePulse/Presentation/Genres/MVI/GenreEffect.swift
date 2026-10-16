//
//  GenreEffect.swift
//  MoviePulse
//
//  Created by sergio.gomez.local on 29/09/2026.
//

enum GenreEffect: Equatable {
    case openMovieDetail(MovieUIModel)
    case goBack
}

@MainActor
protocol GenreEffectHandling: AnyObject {
    func handle(_ effect: GenreEffect)
}
