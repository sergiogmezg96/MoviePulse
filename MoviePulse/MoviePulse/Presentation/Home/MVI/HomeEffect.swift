//
//  HomeEffect.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 08/10/2026.
//

enum HomeEffect: Equatable {
    case openMovieDetail(MovieUIModel)
    case openGenre(HomeGenreSectionUIModel)
}

@MainActor
protocol HomeEffectHandling: AnyObject {
    func handle(_ effect: HomeEffect)
}
