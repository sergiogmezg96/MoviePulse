//
//  MovieGenreListItem.swift
//  MPLibrary
//
//  Created by Sergio Gómez García on 15/09/2026.
//

import SwiftUI

public struct MovieGenreListItemConfig<T: Identifiable> {
    let genreTitle: String
    let subtitle: String
    let subtitleIconName: String
    let movies: [T]
    let imageURL: (T) -> URL?
    let movieTitle: (T) -> String
    let onSeeAllTap: () -> Void
    let onMovieTap: (T) -> Void
    
    public init(
        genreTitle: String,
        subtitle: String,
        subtitleIconName: String = "chevron.right",
        movies: [T],
        imageURL: @escaping (T) -> URL?,
        movieTitle: @escaping (T) -> String,
        onSeeAllTap: @escaping () -> Void,
        onMovieTap: @escaping (T) -> Void
    ) {
        self.genreTitle = genreTitle
        self.subtitle = subtitle
        self.subtitleIconName = subtitleIconName
        self.movies = movies
        self.imageURL = imageURL
        self.movieTitle = movieTitle
        self.onSeeAllTap = onSeeAllTap
        self.onMovieTap = onMovieTap
    }
}

public struct MovieGenreListItem<T: Identifiable>: View {
    let config: MovieGenreListItemConfig<T>
    
    public init(config: MovieGenreListItemConfig<T>) {
        self.config = config
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: CustomSize.size4) {
            HStack {
                Text(config.genreTitle)
                    .font(FontSize.title3Bold)
                    .foregroundColor(AppColor.textPrimary)
                
                Spacer()
                
                Button(action: config.onSeeAllTap) {
                    HStack(spacing: CustomSize.size8) {
                        Text(config.subtitle)
                            .font(FontSize.subheadline)
                        
                        Image(systemName: config.subtitleIconName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: CustomSize.size10, height: CustomSize.size10)
                    }
                    .foregroundColor(AppColor.textSecondary)
                    .padding(.horizontal, CustomSize.size4)
                }
                .buttonStyle(.plain)
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: CustomSize.size14) {
                    ForEach(config.movies) { movie in
                        MoviePosterItem(
                            imageURL: config.imageURL(movie),
                            title: config.movieTitle(movie),
                            onTap: {
                                config.onMovieTap(movie)
                            }
                        )
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, CustomSize.size12)
    }
}

private struct MoviePosterItem: View {
    let imageURL: URL?
    let title: String
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: CustomSize.size8) {
                posterImage
                    .frame(width: Constants.posterWidth, height: Constants.posterHeight)
                    .clipShape(RoundedRectangle(cornerRadius: CustomSize.size8))
                    .overlay {
                        RoundedRectangle(cornerRadius: CustomSize.size8)
                            .stroke(AppColor.border, lineWidth: BorderSize.extraSmall)
                    }
                
                Text(title)
                    .font(FontSize.captionSemibold)
                    .foregroundColor(AppColor.textPrimary)
                    .lineLimit(2)
                    .frame(width: Constants.posterWidth, alignment: .leading)
            }
        }
        .buttonStyle(.plain)
    }
    
    @ViewBuilder
    private var posterImage: some View {
        if let imageURL {
            AsyncImage(url: imageURL) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                case .failure:
                    placeholderImage
                case .empty:
                    placeholderImage
                        .redacted(reason: .placeholder)
                @unknown default:
                    placeholderImage
                }
            }
        } else {
            placeholderImage
        }
    }
    
    private var placeholderImage: some View {
        ZStack {
            AppColor.surfaceElevated
            
            Image(systemName: "film")
                .font(FontSize.title2)
                .foregroundColor(AppColor.textSecondary)
        }
    }
    
    private enum Constants {
        static let posterWidth: CGFloat = 120
        static let posterHeight: CGFloat = 180
    }
}

#Preview {
    ScrollView {
        VStack(alignment: .leading) {
            MovieGenreListItem(
                config: MovieGenreListItemConfig(
                    genreTitle: "Sci-Fi",
                    subtitle: "See All",
                    movies: PreviewMovie.samples,
                    imageURL: { $0.imageURL },
                    movieTitle: { $0.title },
                    onSeeAllTap: {},
                    onMovieTap: { _ in }
                ))
            MovieGenreListItem(
                config: MovieGenreListItemConfig(
                    genreTitle: "Sci-Fi",
                    subtitle: "See All",
                    movies: PreviewMovie.samples,
                    imageURL: { $0.imageURL },
                    movieTitle: { $0.title },
                    onSeeAllTap: {},
                    onMovieTap: { _ in }
                ))
            MovieGenreListItem(
                config: MovieGenreListItemConfig(
                    genreTitle: "Sci-Fi",
                    subtitle: "See All",
                    movies: PreviewMovie.samples,
                    imageURL: { $0.imageURL },
                    movieTitle: { $0.title },
                    onSeeAllTap: {},
                    onMovieTap: { _ in }
                ))
            MovieGenreListItem(
                config: MovieGenreListItemConfig(
                    genreTitle: "Sci-Fi",
                    subtitle: "See All",
                    movies: PreviewMovie.samples,
                    imageURL: { $0.imageURL },
                    movieTitle: { $0.title },
                    onSeeAllTap: {},
                    onMovieTap: { _ in }
                ))
            MovieGenreListItem(
                config: MovieGenreListItemConfig(
                    genreTitle: "Sci-Fi",
                    subtitle: "See All",
                    movies: PreviewMovie.samples,
                    imageURL: { $0.imageURL },
                    movieTitle: { $0.title },
                    onSeeAllTap: {},
                    onMovieTap: { _ in }
                ))
            Spacer()
        }
    }
    .padding(.horizontal, CustomSize.size24)
    .background(AppColor.background)
}

private struct PreviewMovie: Identifiable {
    let id = UUID()
    let title: String
    let imageURL: URL?
    
    static let samples = [
        PreviewMovie(title: "Orbital Drift", imageURL: nil),
        PreviewMovie(title: "The Aether Project", imageURL: nil),
        PreviewMovie(title: "Nova Fall", imageURL: nil),
        PreviewMovie(title: "Orbital Drift", imageURL: nil),
        PreviewMovie(title: "The Aether Project", imageURL: nil),
        PreviewMovie(title: "Nova Fall", imageURL: nil)
    ]
}
