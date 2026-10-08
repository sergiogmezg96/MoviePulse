//
//  HomeIntent.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 08/09/2026.
//

enum HomeIntent {
    case viewDidAppear
    case selectGenre(HomeGenreSectionUIModel)
    case toggleFeaturedMovieInMyList(MovieUIModel)
    case selectMovie(MovieUIModel)
    case moviesLoaded(
        featuredMovie: MovieUIModel?,
        isFeaturedMovieInMyList: Bool,
        genreSections: [HomeGenreSectionUIModel]
    )
    case moviesFailed(message: String)
    case featuredMovieMyListUpdated(isInMyList: Bool)
    // case selectProfile
    // case submitSearch(query: String)
}
