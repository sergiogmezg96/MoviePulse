//
//  AppConstants.swift
//  MoviePulse
//
//  Created by sergio.gomez.local on 07/10/2026.
//

import Foundation

enum AppConstants {
    enum Tab: CaseIterable {
        case home
        case browse
        case myList
        case downloads

        var title: String {
            switch self {
            case .home: String(localized: "tab_home")
            case .browse: String(localized: "tab_browse")
            case .myList: String(localized: "tab_my_list")
            case .downloads: String(localized: "tab_downloads")
            }
        }

        var icon: String {
            switch self {
            case .home: "house.fill"
            case .browse: "movieclapper"
            case .myList: "tv"
            case .downloads: "arrow.down.to.line"
            }
        }
    }
}
