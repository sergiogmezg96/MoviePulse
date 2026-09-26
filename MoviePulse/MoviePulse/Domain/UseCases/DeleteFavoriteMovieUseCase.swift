//
//  DeleteFavoriteMovieUseCase.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 26/09/2026.
//

import Foundation
import MPLibrary

public struct DeleteFavoriteMovieUseCase: MPUseCase {
    private let repository: MovieRepository

    public init(repository: MovieRepository) {
        self.repository = repository
    }

    public func execute(request id: Int) async throws {
        try await repository.delete(id)
    }
}
