//
//  HomeCommand.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 08/10/2026.
//

enum HomeCommand {
    case loadMovies
    case updateFeaturedMovieInMyList(MovieUIModel, isCurrentlyInMyList: Bool)
}
