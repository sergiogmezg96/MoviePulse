//
//  GetFavoriteMovieByIdUseCase.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 26/09/2026.
//

import Foundation
import MPLibrary

public struct GetFavoriteMovieByIdUseCase: MPUseCase {
    private let repository: MovieRepository

    public init(repository: MovieRepository) {
        self.repository = repository
    }

    public func execute(request id: Int) async throws -> FavoriteMovieDomainModel? {
        try await repository.getFavorite(by: id)
    }
}
