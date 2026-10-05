//
//  GetMoviesUseCase.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 22/09/2026.
//

import Foundation
import MPLibrary

struct GetMoviesUseCase: MPUseCase {
    private let repository: MovieRepository
    
    init(repository: MovieRepository) {
        self.repository = repository
    }
    
    func execute(request: ()) async throws -> [MovieDomainModel] {
        try await repository.getMovies()
    }
}
