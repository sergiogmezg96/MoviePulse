//
//  HomeMoviesMapper.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 22/09/2026.
//

import Foundation
import MPLibrary

struct HomeMoviesMapper {
    func mapFeaturedMovie(_ movies: [MovieDomainModel]) -> MovieUIModel? {
        movies
            .filter { !$0.releaseDate.isEmpty }
            .max { firstMovie, secondMovie in
                firstMovie.releaseDate < secondMovie.releaseDate
            }
            .map(mapMovie)
    }

    func map(_ movies: [MovieDomainModel]) -> [HomeGenreSectionUIModel] {
        uniqueGenreIds(from: movies).map { genreId in
            let genreMovies = movies.filter { movie in
                movie.genreIds.contains(genreId)
            }

            return mapGenreSection(
                genreId: genreId,
                movies: genreMovies
            )
        }
    }

    func mapFavoriteMovie(_ movie: MovieUIModel) -> FavoriteMovieDomainModel {
        FavoriteMovieDomainModel(
            id: movie.id,
            title: movie.title,
            subtitle: movie.subtitle,
            overview: movie.overview,
            releaseDate: movie.releaseDate,
            voteAverage: movie.voteAverage,
            imageURL: movie.imageURL,
            backdropURL: movie.backdropURL
        )
    }

    private func uniqueGenreIds(from movies: [MovieDomainModel]) -> [Int] {
        movies.reduce(into: []) { genreIds, movie in
            movie.genreIds.forEach { genreId in
                guard !genreIds.contains(genreId) else {
                    return
                }

                genreIds.append(genreId)
            }
        }
    }

    private func mapGenreSection(
        genreId: Int,
        movies: [MovieDomainModel]
    ) -> HomeGenreSectionUIModel {
        HomeGenreSectionUIModel(
            id: genreId,
            title: genreTitle(for: genreId),
            movies: movies.map(mapMovie)
        )
    }

    private func mapMovie(_ movie: MovieDomainModel) -> MovieUIModel {
        MovieUIModel(
            id: movie.id,
            title: movie.title,
            subtitle: movie.genreIds.first.map(genreTitle) ?? "",
            overview: movie.overview,
            releaseDate: movie.releaseDate,
            voteAverage: movie.voteAverage,
            imageURL: makePosterURL(from: movie.posterPath),
            backdropURL: makeBackdropURL(from: movie.backdropPath)
        )
    }

    private func makePosterURL(from posterPath: String?) -> URL? {
        guard let posterPath else {
            return nil
        }

        return URL(string: "\(Constants.HomeMoviesConstants.posterBaseURL)\(posterPath)")
    }

    private func makeBackdropURL(from backdropPath: String?) -> URL? {
        guard let backdropPath else {
            return nil
        }

        return URL(string: "\(Constants.HomeMoviesConstants.backdropBaseURL)\(backdropPath)")
    }

    private func genreTitle(for genreId: Int) -> String {
        guard let titleKey = Constants.HomeMoviesConstants.genreTitleKeys[genreId] else {
            return "\(String(localized: "genre_unknown")) \(genreId)"
        }

        return String(localized: String.LocalizationValue(titleKey))
    }
}
