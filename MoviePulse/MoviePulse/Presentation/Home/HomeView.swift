//
//  HomeView.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 08/09/2026.
//

import SwiftUI
import MPLibrary

struct HomeView: View {
    let store: HomeStore
    let onMovieTap: (HomeMovieUIModel) -> Void
    
    init(
        store: HomeStore,
        onMovieTap: @escaping (HomeMovieUIModel) -> Void = { _ in }
    ) {
        self.store = store
        self.onMovieTap = onMovieTap
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: CustomSize.size0) {
                HeaderSection()
                DiscoverSection(
                    movie: store.state.featuredMovie,
                    onTap: onMovieTap
                )
                content
            }
        }
        .background(AppColor.background.opacity(0.95))
        .task {
            store.process(.viewDidAppear)
        }
    }

    @ViewBuilder
    private var content: some View {
        switch store.state.status {
        case .idle, .loading:
            ProgressView()
                .padding(.top, CustomSize.size24)
        case .loaded:
            MovieGenresSection(
                genres: store.state.genreSections,
                onMovieTap: onMovieTap
            )
        case .failed(let message):
            Text(message)
                .font(FontSize.subheadline)
                .foregroundColor(AppColor.textSecondary)
                .padding(.top, CustomSize.size24)
                .padding(.horizontal, CustomSize.size24)
        }
    }
}

private struct MovieGenresSection: View {
    let genres: [HomeGenreSectionUIModel]
    let onMovieTap: (HomeMovieUIModel) -> Void
    
    var body: some View {
        LazyVStack(spacing: CustomSize.size8) {
            ForEach(genres) { genre in
                MovieGenreListItem(
                    config: MovieGenreListItemConfig(
                        genreTitle: genre.title,
                        subtitle: "see-all-key".localized,
                        movies: genre.movies,
                        imageURL: { $0.imageURL },
                        movieTitle: { $0.title },
                        onSeeAllTap: {},
                        onMovieTap: { movie in
                            onMovieTap(movie)
                        }
                    )
                )
            }
        }
        .padding(.horizontal, CustomSize.size24)
    }
}

private struct DiscoverSection: View {
    let movie: HomeMovieUIModel?
    let onTap: (HomeMovieUIModel) -> Void
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                backdropImage
                    .frame(width: proxy.size.width, height: Constants.imageHeight)
                    .clipped()
                
                LinearGradient(
                    colors: [
                        .black.opacity(0.65),
                        .black.opacity(0.15),
                        .black.opacity(0.80)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                
                VStack {
                    HStack {
                        VStack(alignment: .leading, spacing: CustomSize.size8) {
                            Text(movie?.title ?? "")
                                .font(FontSize.title2Bold)
                                .foregroundColor(AppColor.textPrimary)
                            
                            Text(movie?.subtitle ?? "")
                                .font(FontSize.captionSemibold)
                                .foregroundColor(AppColor.textSecondary)
                            
                            Text(movie?.overview ?? "")
                                .font(FontSize.caption)
                                .foregroundColor(AppColor.textPrimary)
                                .lineLimit(2)
                        }
                        
                        Spacer()
                    }
                    
                    Spacer()
                    
                    HStack(spacing: CustomSize.size8) {
                        MPButton(
                            config: MPButtonConfig(
                                style: .primary,
                                cornerRadius: CustomSize.size10,
                                horizontalPadding: CustomSize.size16,
                                verticalPadding: CustomSize.size10,
                                font: FontSize.captionBold,
                                iconName: "play.fill",
                                text: "Play",
                                action: {}
                            )
                        )
                        
                        MPButton(
                            config: MPButtonConfig(
                                style: .secondary,
                                cornerRadius: CustomSize.size10,
                                horizontalPadding: CustomSize.size16,
                                verticalPadding: CustomSize.size10,
                                font: FontSize.captionBold,
                                iconName: "plus",
                                text: "My List",
                                action: {}
                            )
                        )
                        
                        Spacer()
                        
                        PageIndicator(currentPage: 0, numberOfPages: 3)
                    }
                }
                .padding(CustomSize.size12)
            }
            .clipShape(
                RoundedRectangle(
                    cornerRadius: CustomSize.size8,
                    style: .continuous
                )
            )
            .overlay {
                RoundedRectangle(
                    cornerRadius: CustomSize.size8,
                    style: .continuous
                )
                .stroke(AppColor.border, lineWidth: BorderSize.small)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            guard let movie else {
                return
            }

            onTap(movie)
        }
        .frame(height: Constants.imageHeight)
        .padding(.horizontal, CustomSize.size20)
    }

    @ViewBuilder
    private var backdropImage: some View {
        if let backdropURL = movie?.backdropURL {
            AsyncImage(url: backdropURL) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                case .failure, .empty:
                    placeholderImage
                @unknown default:
                    placeholderImage
                }
            }
        } else {
            placeholderImage
        }
    }

    private var placeholderImage: some View {
        Image("the-last")
            .resizable()
            .scaledToFill()
    }
    
    private enum Constants {
        static let imageHeight: CGFloat = 240
    }
}

private struct PageIndicator: View {
    let currentPage: Int
    let numberOfPages: Int
    
    var body: some View {
        HStack(spacing: CustomSize.size4) {
            ForEach(0..<numberOfPages, id: \.self) { index in
                Circle()
                    .fill(index == currentPage ? AppColor.textPrimary : AppColor.textSecondary)
                    .frame(width: CustomSize.size6, height: CustomSize.size6)
            }
        }
    }
}

private struct HeaderSection: View {
    
    var body: some View {
        HStack {
            (
                Text("Movie")
                    .foregroundColor(AppColor.textPrimary)
                +
                Text("Pulse")
                    .foregroundColor(AppColor.primary)
            )
            .font(FontSize.largeTitleBold)
            
            Spacer()
            
            HStack(spacing: CustomSize.size16) {
                Image(systemName: "magnifyingglass")
                    .font(FontSize.title2)
                    .foregroundColor(AppColor.textPrimary)
                
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: CustomSize.size40, height: CustomSize.size40)
                    .foregroundColor(AppColor.textSecondary)
            }
        }
        .padding(.top, CustomSize.size16)
        .padding(.horizontal, CustomSize.size24)
        .padding(.bottom, CustomSize.size24)
    }
}

#Preview {
    ScrollView {
        VStack(spacing: CustomSize.size0) {
            HeaderSection()
            DiscoverSection(
                movie: HomeMovieUIModel(
                    id: 1,
                    title: "The Last Horizon",
                    subtitle: "Science Fiction",
                    overview: "Adventure beyond the known universe",
                    releaseDate: "2026-01-01",
                    voteAverage: 8,
                    imageURL: nil,
                    backdropURL: nil
                ),
                onTap: { _ in }
            )
            MovieGenresSection(
                genres: [
                    HomeGenreSectionUIModel(
                        id: 0,
                        title: "Trending Now",
                        movies: [
                            HomeMovieUIModel(id: 1, title: "The Last Horizon", subtitle: "Science Fiction", overview: "", releaseDate: "2026-01-01", voteAverage: 8, imageURL: nil, backdropURL: nil),
                            HomeMovieUIModel(id: 2, title: "Orbital Drift", subtitle: "Adventure", overview: "", releaseDate: "2026-01-02", voteAverage: 7, imageURL: nil, backdropURL: nil)
                        ]
                    )
                ],
                onMovieTap: { _ in }
            )
        }
    }
    .background(AppColor.background.opacity(0.95))
}
