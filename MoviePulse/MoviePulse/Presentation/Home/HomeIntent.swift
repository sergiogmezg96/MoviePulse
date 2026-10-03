//
//  HomeIntent.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 08/09/2026.
//

enum HomeIntent {
    case viewDidAppear
    case selectGenre(HomeGenreSectionUIModel)
    case addMovieToMyList(MovieUIModel)
    case selectMovie(MovieUIModel)
    case selectProfile
    case submitSearch(query: String)
}
