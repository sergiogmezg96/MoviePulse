//
//  HomeGenreSectionUIModel.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 26/09/2026.
//

import Foundation

struct HomeGenreSectionUIModel: Equatable, Identifiable {
    let id: Int
    let title: String
    let movies: [MovieUIModel]
}
