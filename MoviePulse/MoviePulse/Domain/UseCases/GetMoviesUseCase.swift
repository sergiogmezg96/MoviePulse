//
//  GetMoviesUseCase.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 22/09/2026.
//

import Foundation
import MPLibrary

public struct GetMoviesUseCase: MPUseCase {
    private let repository: MovieRepository
    
    public init (repository: MovieRepository) {
        self.repository = repository
    }
    
    public func execute(request: ()) async throws -> [MovieDomainModel] {
        try await repository.getMovies()
    }
}
