//
//  MyListFilter.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 13/10/2026.
//

import Foundation
import MPLibrary

enum MyListFilter: CaseIterable, Identifiable {
    case movies
    case topRated
    case recentlyAdded

    var id: Self {
        self
    }

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
