//
//  SearchView.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 11/10/2026.
//

import Foundation
import SwiftUI
import MPLibrary

struct SearchView: View {
    let store: SearchStore

    var body: some View {
        ZStack {
            AppColor.background.opacity(0.95).ignoresSafeArea()

            VStack(spacing: CustomSize.size20) {
                MPNavigationHeaderBar(
                    config: MPNavigationHeaderBarConfig(
                        onLeadingTap: {
                            store.process(.dismiss)
                        }
                    )
                )
                .padding(.top, CustomSize.size20)

                SearcherItemView(
                    config: SearcherItemViewConfig(
                        placeholder: "search_placeholder".localized,
                        text: searchText,
                        leftIcon: "magnifyingglass"
                    )
                )

                content
            }
            .padding(.horizontal, CustomSize.size24)
        }
        .task {
            store.process(.viewDidAppear)
        }
    }

    private var searchText: Binding<String> {
        Binding(
            get: { store.state.query },
            set: { store.process(.queryChanged($0)) }
        )
    }

    @ViewBuilder
    private var content: some View {
        switch store.state.status {
        case .idle, .loading:
            centeredContent {
                ProgressView()
            }
        case .loaded:
            if store.filteredMovies.isEmpty {
                centeredContent {
                    Text("search_empty_results".localized)
                        .font(FontSize.subheadline)
                        .foregroundColor(AppColor.textSecondary)
                        .multilineTextAlignment(.center)
                }
            } else {
                ScrollView {
                    LazyVGrid(columns: gridColumns, spacing: CustomSize.size24) {
                        ForEach(store.filteredMovies) { movie in
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
                    .padding(.bottom, CustomSize.size24)
                }
                .scrollIndicators(.hidden)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        case .failed(let message):
            centeredContent {
                Text(message)
                    .font(FontSize.subheadline)
                    .foregroundColor(AppColor.textSecondary)
                    .multilineTextAlignment(.center)
            }
        }
    }

    private func centeredContent<Content: View>(
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack {
            Spacer()
            content()
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private var gridColumns: [GridItem] {
        [
            GridItem(.flexible(), spacing: CustomSize.size8),
            GridItem(.flexible(), spacing: CustomSize.size8)
        ]
    }
}
