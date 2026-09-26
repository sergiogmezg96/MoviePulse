//
//  MovieDetailView.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 20/09/2026.
//

import SwiftUI
import MPLibrary

struct MovieDetailView: View {
    let movie: HomeMovieUIModel
    let onBackTap: () -> Void

    init(
        movie: HomeMovieUIModel,
        onBackTap: @escaping () -> Void = {}
    ) {
        self.movie = movie
        self.onBackTap = onBackTap
    }

    var body: some View {
        ZStack(alignment: .top) {
            AppColor.background.opacity(0.95).ignoresSafeArea()
            
            HeaderBackgroundImage(imageURL: movie.backdropURL)
                .ignoresSafeArea(edges: .top)
                .zIndex(0)
            
            VStack(spacing: CustomSize.size24) {
                HeaderSection(onBackTap: onBackTap)
                    .padding(.top, CustomSize.size16)
                    .zIndex(1)
                
                MovieInfoSection(movie: movie)
                    .zIndex(1)
                
                MovieOverviewSection(movie: movie)
                    .zIndex(1)
            }
        }
    }
}

private  struct MovieInfoSection: View {
    let movie: HomeMovieUIModel

    var body: some View {
        VStack(alignment: .leading, spacing: CustomSize.size16) {
            HStack(alignment: .bottom) {
                PosterImage(imageURL: movie.imageURL)
                    .frame(width: 120, height: 160)
                    .clipped()
                
                Spacer()
                
                VStack(alignment: .leading, spacing: CustomSize.size4) {
                    
                    Text(movie.title)
                        .font(FontSize.title2Bold)
                        .foregroundColor(AppColor.textPrimary)
                    
                    Text(movie.releaseDate)
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
                    }
                }
                
                Spacer()
            }
        }
        .padding(.horizontal, CustomSize.size24)
    }
}

private struct MovieOverviewSection: View {
    let movie: HomeMovieUIModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: CustomSize.size12) {
            HStack(spacing: CustomSize.size8) {
                VStack {
                    RatingView(rating: movie.voteAverage)
                }
                
                HStack {
                    Text(movie.subtitle)
                        .font(FontSize.subheadline)
                        .foregroundColor(AppColor.textSecondary)
                }
                
                Spacer()
            }
            
            ScrollView {
                Text(movie.overview)
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
    let onBackTap: () -> Void

    var body: some View {
        ZStack {
            title
            
            HStack {
                headerButton(
                    iconName: "chevron.left",
                    color: AppColor.textPrimary,
                    action: onBackTap
                )
                
                Spacer()
                
                headerButton(
                    iconName: "heart",
                    color: Color.red,
                    action: {}
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
        movie: HomeMovieUIModel(
            id: 1,
            title: "The Last Horizon",
            subtitle: "Science Fiction",
            overview: "Adventure beyond the known universe",
            releaseDate: "2026-01-01",
            voteAverage: 8,
            imageURL: nil,
            backdropURL: nil,
        )
    )
}
