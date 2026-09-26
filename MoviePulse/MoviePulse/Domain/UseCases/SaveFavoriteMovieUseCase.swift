//
//  SaveFavoriteMovieUseCase.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 26/09/2026.
//

import Foundation
import MPLibrary

struct SaveFavoriteMovieUseCase: MPUseCase {
    private let repository: MovieRepository

    init(repository: MovieRepository) {
        self.repository = repository
    }

    func execute(request movie: FavoriteMovieDomainModel) async throws {
        try await repository.saveFavorite(movie)
    }
}
