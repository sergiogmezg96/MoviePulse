//
//  MoviePulseConfiguration.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 22/09/2026.
//

import Foundation

enum MoviePulseConfiguration {
    static var tmdbApiKey: String {
        value(for: "TMDBAPIKey")
        ?? value(for: "TMDB_API_KEY")
        ?? ""
    }

    private static func value(for key: String) -> String? {
        guard let rawValue = Bundle.main.object(forInfoDictionaryKey: key) as? String else {
            return nil
        }

        let value = rawValue.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !value.isEmpty, !value.contains("$(") else {
            return nil
        }

        return value
    }

}
