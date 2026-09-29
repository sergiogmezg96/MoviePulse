//
//  MovieDetailView.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 20/09/2026.
//

import SwiftUI
import MPLibrary

struct MovieDetailView: View {
    let store: MovieDetailStore

    init(
        store: MovieDetailStore
    ) {
        self.store = store
    }

    var body: some View {
        ZStack(alignment: .top) {
            AppColor.background.opacity(0.95).ignoresSafeArea()
            
            HeaderBackgroundImage(imageURL: store.state.movie?.backdropURL)
                .ignoresSafeArea(edges: .top)
                .zIndex(0)
            
            VStack(spacing: CustomSize.size24) {
                HeaderSection(store: store)
                    .zIndex(1)
                
                content
            }
        }
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
            MovieInfoSection(store: store)
            .zIndex(1)

            MovieOverviewSection(movie: store.state.movie)
                .zIndex(1)
        case .failed(let message):
            Text(message)
                .font(FontSize.subheadline)
                .foregroundColor(AppColor.textSecondary)
                .padding(.top, CustomSize.size24)
                .padding(.horizontal, CustomSize.size24)
        }
    }
}

private  struct MovieInfoSection: View {
    let store: MovieDetailStore

    var body: some View {
        VStack(alignment: .leading, spacing: CustomSize.size16) {
            HStack(alignment: .bottom) {
                PosterImage(imageURL: store.state.movie?.imageURL)
                    .frame(width: 120, height: 160)
                    .clipped()
                
                Spacer()
                
                VStack(alignment: .leading, spacing: CustomSize.size4) {
                    
                    Text(store.state.movie?.title ?? "")
                        .font(FontSize.title2Bold)
                        .foregroundColor(AppColor.textPrimary)
                    
                    Text(store.state.movie?.releaseDate ?? "")
                        .font(FontSize.caption)
                        .foregroundColor(AppColor.textSecondary)
                    
                    HStack(spacing: CustomSize.size16) {
                        MPButton(
                            config: MPButtonConfig(
                                style: .primary,
                                cornerRadius: CustomSize.size10,
                                horizontalPadding: CustomSize.size16,
                                verticalPadding: CustomSize.size10,
                                font: FontSize.captionBold,
                                iconName: "star.fill",
                                text: "movie_detail_rate".localized,
                                action: {
                                    store.process(.rateMovie)
                                }
                            )
                        )
                        
                        MPButton(
                            config: MPButtonConfig(
                                style: .secondary,
                                cornerRadius: CustomSize.size10,
                                horizontalPadding: CustomSize.size16,
                                verticalPadding: CustomSize.size10,
                                font: FontSize.captionBold,
                                iconName: store.state.isInMyList ? "checkmark" : "plus",
                                text: store.state.isInMyList ? "movie_detail_added_to_list".localized : "tab_my_list".localized,
                                action: {
                                    store.process(.toggleMyList)
                                }
                            )
                        )
                    }
                }
                
                Spacer()
            }
        }
        .padding(.horizontal, CustomSize.size24)
    }
}

private struct MovieOverviewSection: View {
    let movie: MovieUIModel?
    
    var body: some View {
        VStack(alignment: .leading, spacing: CustomSize.size12) {
            HStack(spacing: CustomSize.size8) {
                VStack {
                    RatingView(rating: movie?.voteAverage ?? 0)
                }
                
                HStack {
                    Text(movie?.subtitle ?? "")
                        .font(FontSize.subheadline)
                        .foregroundColor(AppColor.textSecondary)
                }
                
                Spacer()
            }
            
            ScrollView {
                Text(movie?.overview ?? "")
                    .font(FontSize.body)
                    .foregroundColor(AppColor.textSecondary)
                    .lineSpacing(CustomSize.size4)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .scrollIndicators(.hidden)
        }
        .padding(.horizontal, CustomSize.size24)
    }
}

private struct RatingView: View {
    let rating: Double
    
    var body: some View {
        HStack(spacing: CustomSize.size2) {
            ForEach(0..<5, id: \.self) { index in
                starImage(for: index)
                    .font(FontSize.body)
                    .foregroundColor(AppColor.primary)
            }
        }
        .padding(.vertical, CustomSize.size8)
    }

    private var starsRating: Double {
        rating / 2
    }

    private func starImage(for index: Int) -> Image {
        let starValue = Double(index) + 1

        if starsRating >= starValue {
            return Image(systemName: "star.fill")
        }

        if starsRating >= starValue - 0.5 {
            return Image(systemName: "star.leadinghalf.filled")
        }

        return Image(systemName: "star")
    }
}

private struct HeaderBackgroundImage: View {
    let imageURL: URL?

    var body: some View {
        VStack(spacing: CustomSize.size0) {
            RemoteMovieImage(imageURL: imageURL)
                .frame(maxWidth: .infinity)
                .frame(height: .headerBackgroundImageHeight)
                .clipped()
                .overlay {
                    LinearGradient(
                        colors: [
                            .clear,
                            AppColor.background.opacity(0.35),
                            AppColor.background.opacity(0.95)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                }
        }
    }
}

private struct PosterImage: View {
    let imageURL: URL?

    var body: some View {
        RemoteMovieImage(imageURL: imageURL)
    }
}

private struct RemoteMovieImage: View {
    let imageURL: URL?

    var body: some View {
        if let imageURL {
            AsyncImage(url: imageURL) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                case .failure, .empty:
                    placeholder
                @unknown default:
                    placeholder
                }
            }
        } else {
            placeholder
        }
    }

    private var placeholder: some View {
        Image("the-last")
            .resizable()
            .scaledToFill()
    }
}

private struct HeaderSection: View {
    let store: MovieDetailStore

    var body: some View {
        ZStack {
            title
            
            HStack {
                headerButton(
                    iconName: "chevron.left",
                    color: AppColor.textPrimary,
                    action: {
                        store.process(.goBack)
                    }
                )
                
                Spacer()
                
                headerButton(
                    iconName: store.state.isFavorite ? "heart.fill" : "heart",
                    color: Color.red,
                    action: {
                        store.process(.toggleFavorite)
                    }
                )
            }
        }
        .padding(.horizontal, CustomSize.size24)
        .padding(.bottom, CustomSize.size24)
    }
    
    private var title: some View {
        (
            Text("Movie")
                .foregroundColor(AppColor.textPrimary)
            +
            Text("Pulse")
                .foregroundColor(AppColor.primary)
        )
        .font(FontSize.headlineBold)
    }
    
    private func headerButton(
        iconName: String,
        color: Color,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Image(systemName: iconName)
                .font(FontSize.headline)
                .foregroundColor(color)
                .frame(width: CustomSize.size32, height: CustomSize.size32)
                .background(AppColor.background.opacity(0.85))
                .clipShape(Circle())
        }
        .buttonStyle(.plain)
    }
}

private extension CGFloat {
    static let headerBackgroundImageHeight: CGFloat = 240
}

#Preview {
    MovieDetailView(
        store: MovieDetailStore(
            state: .initial(
                movie: MovieUIModel(
                    id: 1,
                    title: "The Last Horizon",
                    subtitle: "Science Fiction",
                    overview: "Adventure beyond the known universe",
                    releaseDate: "2026-01-01",
                    voteAverage: 8,
                    imageURL: nil,
                    backdropURL: nil,
                )
            ),
            saveFavoriteMovieUseCase: SaveFavoriteMovieUseCase(
                repository: MovieRepositoryImpl(apiKey: "")
            ),
            deleteFavoriteMovieUseCase: DeleteFavoriteMovieUseCase(
                repository: MovieRepositoryImpl(apiKey: "")
            ),
            getFavoriteMovieByIdUseCase: GetFavoriteMovieByIdUseCase(
                repository: MovieRepositoryImpl(apiKey: "")
            ),
            saveMovieToMyListUseCase: SaveMovieToMyListUseCase(
                repository: MovieRepositoryImpl(apiKey: "")
            ),
            deleteMovieFromMyListUseCase: DeleteMovieFromMyListUseCase(
                repository: MovieRepositoryImpl(apiKey: "")
            ),
            getMyListMovieByIdUseCase: GetMyListMovieByIdUseCase(
                repository: MovieRepositoryImpl(apiKey: "")
            ),
            onBackTap: {}
        )
    )
}
