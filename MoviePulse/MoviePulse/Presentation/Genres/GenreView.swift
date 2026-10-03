//
//  GenreView.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 29/09/2026.
//

import SwiftUI
import MPLibrary

struct GenreView: View {
    @State private var selectedFilter: GenreFilter = .movies
    
    let imageURL: URL?
    let imageName: String?
    let onBackTap: () -> Void
    let onSearchTap: () -> Void
    
    init(
        imageURL: URL? = nil,
        imageName: String? = nil,
        onBackTap: @escaping () -> Void = {},
        onSearchTap: @escaping () -> Void = {}
    ) {
        self.imageURL = imageURL
        self.imageName = imageName
        self.onBackTap = onBackTap
        self.onSearchTap = onSearchTap
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            AppColor.background.opacity(0.95).ignoresSafeArea()
            
            MPHeaderBackgroundImage(
                config: MPHeaderBackgroundImageConfig(
                    imageURL: imageURL,
                    imageName: imageName,
                    contentMode: .fit
                )
            )
            .ignoresSafeArea(edges: .top)
            .zIndex(0)
            
            VStack(spacing: CustomSize.size20) {
                MPNavigationHeaderBar(
                    config: MPNavigationHeaderBarConfig(
                        trailingIconName: "magnifyingglass",
                        onLeadingTap: onBackTap,
                        onTrailingTap: onSearchTap
                    )
                )
                .zIndex(1)
                
                
                VStack(spacing: CustomSize.size6) {
                    HStack {
                        Text("SCI-FI")
                            .foregroundStyle(AppColor.textPrimary)
                            .font(FontSize.largeTitleBold)
                            .fixedSize()
                        Spacer()
                    }
                    
                    HStack {
                        Text("18 películas")
                            .foregroundStyle(AppColor.textPrimary)
                            .font(FontSize.footnote)
                            .fixedSize()
                        Spacer()
                    }
                    
                    HStack(spacing: CustomSize.size8) {
                        ForEach(GenreFilter.allCases) { filter in
                            MPSelectableChip(
                                config: MPSelectableChipConfig(
                                    title: filter.title,
                                    isSelected: selectedFilter == filter,
                                    action: {
                                        selectedFilter = filter
                                    }
                                )
                            )
                        }
                    }
                    .padding(.vertical, CustomSize.size4)
                }
                .padding(.horizontal, CustomSize.size24)
                
                ScrollView {
                    LazyVGrid(
                        columns: [
                            GridItem(.flexible(), spacing: CustomSize.size4),
                            GridItem(.flexible(), spacing: CustomSize.size4)
                        ],
                        spacing: CustomSize.size24
                    ) {
                        ForEach(PreviewGenreMovie.movies) { movie in
                            MPMovieGridItem(
                                config: MPMovieGridItemConfig(
                                    imageName: movie.imageName,
                                    title: movie.title,
                                    releaseDate: movie.releaseDate,
                                    rating: movie.rating,
                                    action: {}
                                )
                            )
                        }
                    }
                    .padding(.horizontal, CustomSize.size8)
                }
                .scrollIndicators(.hidden)
            }
        }
    }
}

private enum GenreFilter: CaseIterable, Identifiable {
    case movies
    case topRated
    case recentlyAdded
    
    var id: Self {
        self
    }
    
    var title: String {
        switch self {
        case .movies:
            return "Pelis"
        case .topRated:
            return "Most Rated"
        case .recentlyAdded:
            return "Recientes"
        }
    }
}

private struct PreviewGenreMovie: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    let releaseDate: String
    let rating: String
    
    static let movies = [
        PreviewGenreMovie(imageName: "the-last", title: "Orbital Drift", releaseDate: "2024", rating: "8.7"),
        PreviewGenreMovie(imageName: "the-last", title: "Nova Fall", releaseDate: "2024", rating: "8.7"),
        PreviewGenreMovie(imageName: "the-last", title: "Echoes Beyond", releaseDate: "2023", rating: "8.8"),
        PreviewGenreMovie(imageName: "the-last", title: "The Aether Project", releaseDate: "2024", rating: "9.1"),
        PreviewGenreMovie(imageName: "the-last", title: "Chroma", releaseDate: "2024", rating: "8.7"),
        PreviewGenreMovie(imageName: "the-last", title: "The Silent Skies", releaseDate: "2023", rating: "8.5"),
        PreviewGenreMovie(imageName: "the-last", title: "The Black Tide", releaseDate: "2024", rating: "8.4"),
        PreviewGenreMovie(imageName: "the-last", title: "The Last Horizon", releaseDate: "2026", rating: "9.8")
    ]
}

#Preview {
    GenreView(imageName: "the-last")
}
