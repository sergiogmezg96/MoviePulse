//
//  GetFavoriteMoviesUseCase.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 26/09/2026.
//

import Foundation
import MPLibrary

public struct GetFavoriteMoviesUseCase: MPUseCase {
    private let repository: MovieRepository

    public init(repository: MovieRepository) {
        self.repository = repository
    }

    public func execute(request: ()) async throws -> [FavoriteMovieDomainModel] {
        try await repository.getFavorites()
    }
}
