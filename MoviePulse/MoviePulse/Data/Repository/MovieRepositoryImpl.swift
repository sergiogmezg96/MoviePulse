//
//  MovieRepositoryImpl.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 08/09/2026.
//

import Foundation

struct MovieRepositoryImpl: MovieRepository {
    private let apiKey: String

    init(apiKey: String) {
        self.apiKey = apiKey
    }

    func getMovies() async throws -> [any MovieDomainModel] {
        let endpoint = ApiNetwork.makeEndpoint(
            path: ApiPath.Movie.popular,
            apiKey: apiKey,
            queryItems: ApiNetwork.defaultMovieQueryItems()
        )

        let request = ApiRequest(
            url: endpoint,
            method: .get
        )

        let response: MoviesResponseModel = try await ApiNetworkExecutor.execute(
            request,
            type: MoviesResponseModel.self
        )

        return response.results.map(\.domainModel)
    }
}
