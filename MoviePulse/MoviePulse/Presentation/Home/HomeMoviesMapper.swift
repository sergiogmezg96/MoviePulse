//
//  HomeMoviesMapper.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 22/09/2026.
//
import Foundation

struct HomeMoviesMapper {
    func mapFeaturedMovie(_ movies: [MovieDomainModel]) -> HomeMovieViewData? {
        movies
            .filter { !$0.releaseDate.isEmpty }
            .max { firstMovie, secondMovie in
                firstMovie.releaseDate < secondMovie.releaseDate
            }
            .map(mapMovie)
    }

    func map(_ movies: [MovieDomainModel]) -> [HomeGenreSectionViewData] {
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
    ) -> HomeGenreSectionViewData {
        HomeGenreSectionViewData(
            id: genreId,
            title: genreTitle(for: genreId),
            movies: movies.map(mapMovie)
        )
    }

    private func mapMovie(_ movie: MovieDomainModel) -> HomeMovieViewData {
        HomeMovieViewData(
            id: movie.id,
            title: movie.title,
            subtitle: movie.genreIds.first.map(genreTitle) ?? "",
            overview: movie.overview,
            releaseDate: movie.releaseDate,
            imageURL: makePosterURL(from: movie.posterPath),
            backdropURL: makeBackdropURL(from: movie.backdropPath)
        )
    }

    private func makePosterURL(from posterPath: String?) -> URL? {
        guard let posterPath else {
            return nil
        }

        return URL(string: "\(Constants.posterBaseURL)\(posterPath)")
    }

    private func makeBackdropURL(from backdropPath: String?) -> URL? {
        guard let backdropPath else {
            return nil
        }

        return URL(string: "\(Constants.backdropBaseURL)\(backdropPath)")
    }

    private enum Constants {
        static let posterBaseURL = "https://image.tmdb.org/t/p/w500"
        static let backdropBaseURL = "https://image.tmdb.org/t/p/w780"
        static let genreTitleKeys = [
            12: "genre_adventure",
            14: "genre_fantasy",
            16: "genre_animation",
            18: "genre_drama",
            27: "genre_horror",
            28: "genre_action",
            35: "genre_comedy",
            36: "genre_history",
            37: "genre_western",
            53: "genre_thriller",
            80: "genre_crime",
            99: "genre_documentary",
            878: "genre_science_fiction",
            9648: "genre_mystery",
            10402: "genre_music",
            10749: "genre_romance",
            10751: "genre_family",
            10752: "genre_war",
            10770: "genre_tv_movie"
        ]
    }

    private func genreTitle(for genreId: Int) -> String {
        guard let titleKey = Constants.genreTitleKeys[genreId] else {
            return "\(String(localized: "genre_unknown")) \(genreId)"
        }

        return String(localized: String.LocalizationValue(titleKey))
    }
}
