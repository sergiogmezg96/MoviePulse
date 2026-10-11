//
//  SearchEffect.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 11/10/2026.
//

enum SearchEffect: Equatable {
    case dismiss
    case openMovieDetail(MovieUIModel)
}

@MainActor
protocol SearchEffectHandling: AnyObject {
    func handle(_ effect: SearchEffect)
}
