//
//  GenreView.swift
//  MoviePulse
//

import SwiftUI
import MPLibrary

struct GenreView: View {
    let store: GenreStore

    var body: some View {
        ZStack(alignment: .top) {
            AppColor.background.opacity(0.95).ignoresSafeArea()

            MPHeaderBackgroundImage(
                config: MPHeaderBackgroundImageConfig(
                    imageURL: store.state.genre.movies.first?.backdropURL,
                    imageName: store.state.genre.movies.first?.backdropURL == nil ? "the-last" : nil,
                    contentMode: .fit
                )
            )
            .ignoresSafeArea(edges: .top)
            .zIndex(0)

            VStack(spacing: CustomSize.size20) {
                MPNavigationHeaderBar(
                    config: MPNavigationHeaderBarConfig(
                        onLeadingTap: {
                            store.process(.goBack)
                        }
                    )
                )
                .zIndex(1)

                header

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
                                        store.process(.selectMovie(movie))
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

    private var header: some View {
        VStack(spacing: CustomSize.size6) {
            HStack {
                Text(store.state.genre.title.uppercased())
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
                            isSelected: store.state.selectedFilter == filter,
                            action: {
                                store.process(.selectFilter(filter))
                            }
                        )
                    )
                }
            }
            .padding(.vertical, CustomSize.size4)
        }
        .padding(.horizontal, CustomSize.size24)
    }

    private var moviesCountText: String {
        let countKey = filteredMovies.count == 1
            ? "genre_movie_count_singular"
            : "genre_movie_count_plural"
        return "\(filteredMovies.count) \(countKey.localized)"
    }

    private var filteredMovies: [MovieUIModel] {
        switch store.state.selectedFilter {
        case .movies:
            return store.state.genre.movies
        case .topRated:
            return store.state.genre.movies.sorted { $0.voteAverage > $1.voteAverage }
        case .recentlyAdded:
            return store.state.genre.movies.sorted { $0.releaseDate > $1.releaseDate }
        }
    }
}

#Preview {
    GenreView(
        store: GenreStore(
            state: .initial(
                genre: HomeGenreSectionUIModel(
                    id: 1,
                    title: "Science Fiction",
                    movies: [
                        MovieUIModel(id: 1, title: "The Last Horizon", subtitle: "Science Fiction", overview: "", releaseDate: "2026-01-01", voteAverage: 8, imageURL: nil, backdropURL: nil),
                        MovieUIModel(id: 2, title: "Orbital Drift", subtitle: "Adventure", overview: "", releaseDate: "2026-01-02", voteAverage: 7, imageURL: nil, backdropURL: nil)
                    ]
                )
            ),
            effectHandler: PreviewGenreEffectHandler()
        )
    )
}

@MainActor
private final class PreviewGenreEffectHandler: GenreEffectHandling {
    func handle(_ effect: GenreEffect) {}
}
