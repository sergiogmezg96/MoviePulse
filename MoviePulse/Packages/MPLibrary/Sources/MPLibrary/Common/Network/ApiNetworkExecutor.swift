//
//  ApiNetworkExecutor.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 09/09/2026.
//

import Foundation

public enum ApiNetworkExecutor {
    public static func execute<T: Decodable>(
        _ request: ApiRequest,
        type: T.Type
    ) async throws -> T {
        let urlRequest = try ApiNetwork.makeRequest(from: request)

        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw ApiError.invalidResponse
            }

            try validateStatusCode(httpResponse.statusCode)

            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                throw ApiError.dataParsingError
            }
        } catch let error as ApiError {
            throw error
        } catch {
            throw ApiError.networkError(description: error.localizedDescription)
        }
    }
}

private extension ApiNetworkExecutor {
    static func validateStatusCode(_ statusCode: Int) throws {
        switch statusCode {
        case 200...299:
            return
        case 401:
            throw ApiError.unauthorized
        case 403:
            throw ApiError.forbidden
        case 503:
            throw ApiError.serviceUnavailable
        case 500...599:
            throw ApiError.serverError(statusCode: statusCode)
        default:
            throw ApiError.invalidResponse
        }
    }
}
