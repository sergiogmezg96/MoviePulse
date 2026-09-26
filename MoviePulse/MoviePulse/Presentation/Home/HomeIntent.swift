//
//  HomeIntent.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 08/09/2026.
//

enum HomeIntent {
    case viewDidAppear
    case selectGenre(id: Int)
    case addMovieToMyList(MovieDomainModel)
    case selectMovie(MovieDomainModel)
    case selectProfile
    case submitSearch(query: String)
}
