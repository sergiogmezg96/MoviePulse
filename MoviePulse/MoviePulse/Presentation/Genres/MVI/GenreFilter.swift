//
//  GenreFilter.swift
//  MoviePulse
//
//  Created by sergio.gomez.local on 29/09/2026.
//

import MPLibrary

enum GenreFilter: CaseIterable, Identifiable {
    case movies
    case topRated
    case recentlyAdded

    var id: Self { self }

    var title: String {
        switch self {
        case .movies:
            return "genre_filter_movies".localized
        case .topRated:
            return "genre_filter_top_rated".localized
        case .recentlyAdded:
            return "genre_filter_recently_added".localized
        }
    }
}
