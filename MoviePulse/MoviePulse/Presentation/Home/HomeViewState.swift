//
//  HomeViewState.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 08/09/2026.
//

struct HomeViewState: Equatable {
    let title: String
    let subtitle: String
    let plannedSections: [String]

    static let initial = HomeViewState(
        title: "MoviePulse",
        subtitle: "Clean Architecture + MVI con TMDb como API principal.",
        plannedSections: [
            "Peliculas populares y busqueda con TMDb",
            "Detalle de peliculas, reparto e imagenes",
            "Favoritos, autenticacion y recomendaciones con Firebase en fases posteriores",
            "Recomendaciones inteligentes basadas en gustos del usuario"
        ]
    )
}
