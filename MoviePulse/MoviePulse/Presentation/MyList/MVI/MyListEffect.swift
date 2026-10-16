//
//  MyListEffect.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 13/10/2026.
//

import Foundation

enum MyListEffect {
    case openMovieDetail(MovieUIModel)
}

@MainActor
protocol MyListEffectHandling: AnyObject {
    func handle(_ effect: MyListEffect)
}
