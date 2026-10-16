//
//  MovieDetailIntent.swift
//  MoviePulse
//
//  Created by sergio.gomez.local on 26/09/2026.
//

import Foundation

enum MovieDetailIntent {
    case viewDidAppear
    // case rateMovie
    case toggleFavorite
    case toggleMyList
    case goBack
    case movieStatusLoaded(isFavorite: Bool, isInMyList: Bool)
    case movieStatusFailed(message: String)
    case favoriteUpdated(isFavorite: Bool)
    case myListUpdated(isInMyList: Bool)
    case operationFailed(message: String)
    case dismissOperationError
}
