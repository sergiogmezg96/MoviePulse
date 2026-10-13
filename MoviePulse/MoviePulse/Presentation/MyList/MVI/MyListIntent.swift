//
//  MyListIntent.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 03/10/2026.
//

import Foundation

enum MyListIntent {
    case viewDidAppear
    case selectFilter(MyListFilter)
    case selectMovie(MovieUIModel)
    case moviesLoaded(
        favoriteMovies: [MovieUIModel],
        movies: [MovieUIModel]
    )
    case moviesFailed(message: String)
}
