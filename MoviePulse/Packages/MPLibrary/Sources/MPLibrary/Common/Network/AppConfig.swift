//
//  AppConfig.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 09/09/2026.
//

import Foundation

public enum AppConfig {
    public static var tmdbApiKey: String {
        guard
            let apiKey = Bundle.main.object(forInfoDictionaryKey: "TMDB_API_KEY") as? String,
            !apiKey.isEmpty
        else {
            assertionFailure("Missing TMDB_API_KEY")
            return ""
        }

        return apiKey
    }
}
