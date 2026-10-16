//
//  MyListFavoritesMapper.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 06/10/2026.
//

struct MyListFavoritesMapper {
    func map(_ favoriteMovies: [FavoriteMovieDomainModel]) -> [MovieUIModel] {
        favoriteMovies.map { favoriteMovie in
            MovieUIModel(
                id: favoriteMovie.id,
                title: favoriteMovie.title,
                subtitle: favoriteMovie.subtitle,
                overview: favoriteMovie.overview,
                releaseDate: favoriteMovie.releaseDate,
                voteAverage: favoriteMovie.voteAverage,
                imageURL: favoriteMovie.imageURL,
                backdropURL: favoriteMovie.backdropURL
            )
        }
    }
}
