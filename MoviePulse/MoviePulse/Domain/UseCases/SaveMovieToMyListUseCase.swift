//
//  SaveMovieToMyListUseCase.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 26/09/2026.
//

import Foundation
import MPLibrary

struct SaveMovieToMyListUseCase: MPUseCase {
    private let repository: MovieRepository

    init(repository: MovieRepository) {
        self.repository = repository
    }

    func execute(request movie: MovieUIModel) async throws {
        try await repository.saveToMyList(movie)
    }
}
