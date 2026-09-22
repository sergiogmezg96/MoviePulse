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
    
    var body: some View {
        VStack(spacing: CustomSize.size0) {
            HeaderSection()
            DiscoverSection()
            Spacer()
        }
        .background(AppColor.background.opacity(0.95))
    }
}

private struct MovieGenresSection: View {
    let genres: [HomeGenreItem]
    
    var body: some View {
        LazyVStack(spacing: CustomSize.size8) {
            ForEach(genres) { genre in
                MovieGenreListItem(
                    config: MovieGenreListItemConfig(
                        genreTitle: genre.title,
                        subtitle: "See All",
                        movies: genre.movies,
                        imageURL: { $0.imageURL },
                        movieTitle: { $0.title },
                        onSeeAllTap: {},
                        onMovieTap: { _ in }
                    )
                )
            }
        }
        .padding(.horizontal, CustomSize.size24)
    }
}

private struct DiscoverSection: View {
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Image("the-last")
                    .resizable()
                    .scaledToFill()
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
                            Text("The Last Horizon")
                                .font(FontSize.title2Bold)
                                .foregroundColor(AppColor.textPrimary)
                            
                            Text("Science Fiction")
                                .font(FontSize.captionSemibold)
                                .foregroundColor(AppColor.textSecondary)
                            
                            Text("Adventure beyond the known universe")
                                .font(FontSize.caption)
                                .foregroundColor(AppColor.textPrimary)
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
        .frame(height: Constants.imageHeight)
        .padding(.horizontal, CustomSize.size20)
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
            Text("MoviePulse")
                .font(FontSize.largeTitleBold)
                .foregroundColor(AppColor.textPrimary)
            
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
            DiscoverSection()
            MovieGenresSection(genres: HomeGenreItem.samples)
        }
    }
    .background(AppColor.background.opacity(0.95))
}

private struct HomeGenreItem: Identifiable {
    let id = UUID()
    let title: String
    let movies: [HomeMovieItem]
    
    static let samples = [
        HomeGenreItem(title: "Trending Now", movies: HomeMovieItem.samples),
        HomeGenreItem(title: "Sci-Fi", movies: HomeMovieItem.samples),
        HomeGenreItem(title: "Action", movies: HomeMovieItem.samples)
    ]
}

private struct HomeMovieItem: Identifiable {
    let id = UUID()
    let title: String
    let imageURL: URL?
    
    static let samples = [
        HomeMovieItem(title: "Orbital Drift", imageURL: nil),
        HomeMovieItem(title: "The Aether Project", imageURL: nil),
        HomeMovieItem(title: "Nova Fall", imageURL: nil),
        HomeMovieItem(title: "Silent Galaxy", imageURL: nil)
    ]
}
