//
//  GetFavoriteMoviesUseCase.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 26/09/2026.
//

import Foundation
import MPLibrary

struct GetFavoriteMoviesUseCase: MPUseCase {
    private let repository: MovieRepository

    init(repository: MovieRepository) {
        self.repository = repository
    }

    func execute(request: ()) async throws -> [FavoriteMovieDomainModel] {
        try await repository.getFavorites()
    }
}
