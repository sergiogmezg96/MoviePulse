//
//  GenreView.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 29/09/2026.
//

import SwiftUI
import MPLibrary

@MainActor
protocol GenreViewNavigation {
    func openMovieDetail(movie: MovieUIModel)
    func goBack()
}

struct GenreView: View {
    @State private var selectedFilter: GenreFilter = .movies
    
    let genre: HomeGenreSectionUIModel
    let navigation: GenreViewNavigation
    
    init(
        genre: HomeGenreSectionUIModel,
        navigation: GenreViewNavigation
    ) {
        self.genre = genre
        self.navigation = navigation
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            AppColor.background.opacity(0.95).ignoresSafeArea()
            
            MPHeaderBackgroundImage(
                config: MPHeaderBackgroundImageConfig(
                    imageURL: genre.movies.first?.backdropURL,
                    imageName: genre.movies.first?.backdropURL == nil ? "the-last" : nil,
                    contentMode: .fit
                )
            )
            .ignoresSafeArea(edges: .top)
            .zIndex(0)
            
            VStack(spacing: CustomSize.size20) {
                MPNavigationHeaderBar(
                    config: MPNavigationHeaderBarConfig(
                        trailingIconName: "magnifyingglass",
                        onLeadingTap: {
                            navigation.goBack()
                        },
                        onTrailingTap: {}
                    )
                )
                .zIndex(1)
                
                
                VStack(spacing: CustomSize.size6) {
                    HStack {
                        Text(genre.title.uppercased())
                            .foregroundStyle(AppColor.textPrimary)
                            .font(FontSize.largeTitleBold)
                            .fixedSize()
                        Spacer()
                    }
                    
                    HStack {
                        Text(moviesCountText)
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
                        ForEach(filteredMovies) { movie in
                            MPMovieGridItem(
                                config: MPMovieGridItemConfig(
                                    imageURL: movie.imageURL,
                                    title: movie.title,
                                    releaseDate: movie.releaseDate,
                                    rating: String(format: "%.1f", movie.voteAverage),
                                    action: {
                                        navigation.openMovieDetail(movie: movie)
                                    }
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

    private var moviesCountText: String {
        let countKey = filteredMovies.count == 1 ? "genre_movie_count_singular" : "genre_movie_count_plural"
        return "\(filteredMovies.count) \(countKey.localized)"
    }

    private var filteredMovies: [MovieUIModel] {
        switch selectedFilter {
        case .movies:
            return genre.movies
        case .topRated:
            return genre.movies.sorted { lhs, rhs in
                lhs.voteAverage > rhs.voteAverage
            }
        case .recentlyAdded:
            return genre.movies.sorted { lhs, rhs in
                lhs.releaseDate > rhs.releaseDate
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
            return "genre_filter_movies".localized
        case .topRated:
            return "genre_filter_top_rated".localized
        case .recentlyAdded:
            return "genre_filter_recently_added".localized
        }
    }
}

#Preview {
    GenreView(
        genre: HomeGenreSectionUIModel(
            id: 1,
            title: "Science Fiction",
            movies: [
                MovieUIModel(id: 1, title: "The Last Horizon", subtitle: "Science Fiction", overview: "", releaseDate: "2026-01-01", voteAverage: 8, imageURL: nil, backdropURL: nil),
                MovieUIModel(id: 2, title: "Orbital Drift", subtitle: "Adventure", overview: "", releaseDate: "2026-01-02", voteAverage: 7, imageURL: nil, backdropURL: nil)
            ]
        ),
        navigation: PreviewGenreNavigation()
    )
}

@MainActor
private final class PreviewGenreNavigation: GenreViewNavigation {
    func openMovieDetail(movie: MovieUIModel) {}
    func goBack() {}
}
