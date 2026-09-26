//
//  GetMyListMovieByIdUseCase.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 26/09/2026.
//

import Foundation
import MPLibrary

struct GetMyListMovieByIdUseCase: MPUseCase {
    private let repository: MovieRepository

    init(repository: MovieRepository) {
        self.repository = repository
    }

    func execute(request id: Int) async throws -> MovieUIModel? {
        try await repository.getMyListMovieById(by: id)
    }
}
