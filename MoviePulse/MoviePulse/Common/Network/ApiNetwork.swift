//
//  ApiNetwork.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 08/09/2026.
//

import Foundation

public enum ApiNetwork {
    static let baseUrl: String = "https://api.themoviedb.org/3"

    static func makeURL(
        path: String,
        apiKey: String,
        queryItems: [URLQueryItem] = []
    ) -> URL? {
        makeURL(
            path: path,
            queryItems: [
                URLQueryItem(name: "api_key", value: apiKey)
            ] + queryItems
        )
    }

    static func defaultMovieQueryItems(
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
        path: String,
        queryItems: [URLQueryItem]
    ) -> URL? {
        var components = URLComponents(string: baseUrl + path)
        components?.queryItems = queryItems
        return components?.url
    }
}
