//
//  ApiNetwork.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 08/09/2026.
//

import Foundation

public enum ApiNetwork {
    public static func makeRequest(from apiRequest: ApiRequest) throws -> URLRequest {
        guard let url = makeURL(endpoint: apiRequest.url) else {
            throw ApiError.malformedURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = apiRequest.method.value
        request.httpBody = apiRequest.body
        request.setValue(apiRequest.contentType, forHTTPHeaderField: "Content-Type")

        apiRequest.headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }

        return request
    }

    public static func makeEndpoint(
        path: String,
        apiKey: String,
        queryItems: [URLQueryItem] = []
    ) -> Endpoint {
        Endpoint(
            path: path,
            queryItems: [
                URLQueryItem(name: "api_key", value: apiKey)
            ] + queryItems
        )
    }

    public static func defaultMovieQueryItems(
        language: String = "es-ES",
        page: Int = 1
    ) -> [URLQueryItem] {
        [
            URLQueryItem(name: "language", value: language),
            URLQueryItem(name: "page", value: String(page))
        ]
    }
}

private extension ApiNetwork {
    static func makeURL(
        endpoint: Endpoint
    ) -> URL? {
        guard let baseURL = ApiURL.base else {
            return nil
        }

        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
        let path = endpoint.path.hasPrefix("/") ? endpoint.path : "/\(endpoint.path)"
        components?.path += path
        components?.queryItems = endpoint.queryItems
        return components?.url
    }
}
