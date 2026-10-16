//
//  GenreState.swift
//  MoviePulse
//
//  Created by sergio.gomez.local on 29/09/2026.
//

struct GenreState: Equatable {
    let genre: HomeGenreSectionUIModel
    let selectedFilter: GenreFilter

    static func initial(genre: HomeGenreSectionUIModel) -> GenreState {
        GenreState(genre: genre, selectedFilter: .movies)
    }
}
