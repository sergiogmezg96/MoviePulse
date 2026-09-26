//
//  SaveFavoriteMovieUseCase.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 26/09/2026.
//

import Foundation
import MPLibrary

public struct SaveFavoriteMovieUseCase: MPUseCase {
    private let repository: MovieRepository

    public init(repository: MovieRepository) {
        self.repository = repository
    }

    public func execute(request movie: FavoriteMovieDomainModel) async throws {
        try await repository.save(movie)
    }
}
