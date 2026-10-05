//
//  MyListView.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 03/10/2026.
//

import SwiftUI
import MPLibrary

struct MyListView: View {
    @State private var selectedFilter: MyListFilter = .movies

    let store: MyListStore

    init(store: MyListStore) {
        self.store = store
    }

    var body: some View {
        ZStack(alignment: .top) {
            AppColor.background.opacity(0.95).ignoresSafeArea()

            VStack(spacing: CustomSize.size20) {
                header
                content
            }
        }
        .task {
            store.process(.viewDidAppear)
        }
    }

    private var header: some View {
        VStack(spacing: CustomSize.size6) {
            HStack {
                Text("tab_my_list".localized.uppercased())
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
                ForEach(MyListFilter.allCases) { filter in
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
        .padding(.top, CustomSize.size24)
        .padding(.horizontal, CustomSize.size24)
    }

    @ViewBuilder
    private var content: some View {
        switch store.state.status {
        case .idle, .loading:
            ProgressView()
                .padding(.top, CustomSize.size24)
        case .loaded:
            if filteredMovies.isEmpty {
                emptyView
            } else {
                moviesGrid
            }
        case .failed(let message):
            Text(message)
                .font(FontSize.subheadline)
                .foregroundColor(AppColor.textSecondary)
                .padding(.top, CustomSize.size24)
                .padding(.horizontal, CustomSize.size24)
        }
    }

    private var moviesGrid: some View {
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

    private var emptyView: some View {
        Text("my_list_empty".localized)
            .font(FontSize.subheadline)
            .foregroundColor(AppColor.textSecondary)
            .padding(.top, CustomSize.size24)
            .padding(.horizontal, CustomSize.size24)
    }

    private var moviesCountText: String {
        let countKey = filteredMovies.count == 1 ? "genre_movie_count_singular" : "genre_movie_count_plural"
        return "\(filteredMovies.count) \(countKey.localized)"
    }

    private var filteredMovies: [MovieUIModel] {
        switch selectedFilter {
        case .movies:
            return store.state.movies
        case .topRated:
            return store.state.movies.sorted { lhs, rhs in
                lhs.voteAverage > rhs.voteAverage
            }
        case .recentlyAdded:
            return store.state.movies.sorted { lhs, rhs in
                lhs.releaseDate > rhs.releaseDate
            }
        }
    }
}

private enum MyListFilter: CaseIterable, Identifiable {
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
