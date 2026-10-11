//
//  SearchIntent.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 11/10/2026.
//

enum SearchIntent {
    case viewDidAppear
    case queryChanged(String)
    case dismiss
    case selectMovie(MovieUIModel)
}
