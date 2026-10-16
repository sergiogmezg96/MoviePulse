//
//  MovieDetailCommand.swift
//  MoviePulse
//
//  Created by sergio.gomez.local on 16/10/2026.
//

import Foundation

enum MovieDetailCommand {
    case loadMovieStatus(MovieUIModel)
    case updateFavorite(MovieUIModel, isCurrentlyFavorite: Bool)
    case updateMyList(MovieUIModel, isCurrentlyInMyList: Bool)
}
