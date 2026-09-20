//
//  MovieDetailView.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 20/09/2026.
//

import SwiftUI
import MPLibrary

struct MovieDetailView: View {
    var body: some View {
        ZStack(alignment: .top) {
            AppColor.background.opacity(0.95).ignoresSafeArea()
            
            HeaderBackgroundImage()
                .ignoresSafeArea(edges: .top)
                .zIndex(0)
            
            VStack(spacing: CustomSize.size24) {
                HeaderSection()
                    .padding(.top, CustomSize.size16)
                    .zIndex(1)
                
                MovieInfoSection()
                    .zIndex(1)
                
                MovieOverviewSection()
                    .zIndex(1)
            }
        }
    }
}

private  struct MovieInfoSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: CustomSize.size16) {
            HStack(alignment: .bottom) {
                Image("the-last", bundle: .main)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 160)
                    .clipped()
                
                Spacer()
                
                VStack(alignment: .leading, spacing: CustomSize.size4) {
                    
                    Text("The Last of Us")
                        .font(FontSize.title2Bold)
                        .foregroundColor(AppColor.textPrimary)
                    
                    Text("2026")
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
    
    var body: some View {
        VStack(alignment: .leading, spacing: CustomSize.size12) {
            HStack(spacing: CustomSize.size8) {
                VStack {
                    RatingView(rating: 4)
                }
                
                HStack {
                    //TODO: genres list
                    Text("Science Fiction")
                        .font(FontSize.subheadline)
                        .foregroundColor(AppColor.textSecondary)
                    
                    Text("Adventure")
                        .font(FontSize.subheadline)
                        .foregroundColor(AppColor.textSecondary)
                }
                
                Spacer()
            }
            
            ScrollView {
                Text("A research crew uncovers a lost city beyond the known universe and awakens a truth that should have stayed buried.A research crew uncovers a lost city beyond the known universe and awakens a truth that should have stayed buried.A research crew uncovers a lost city beyond the known universe and awakens a truth that should have stayed buried.")
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
    let rating: Int
    
    var body: some View {
        HStack(spacing: CustomSize.size2) {
            ForEach(0..<5, id: \.self) { index in
                Image(systemName: index < rating ? "star.fill" : "star")
                    .font(FontSize.body)
                    .foregroundColor(AppColor.primary)
            }
        }
        .padding(.vertical, CustomSize.size8)
    }
}

private struct HeaderBackgroundImage: View {
    var body: some View {
        VStack(spacing: CustomSize.size0) {
            Image("the-last")
                .resizable()
                .scaledToFill()
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

private struct HeaderSection: View {
    var body: some View {
        ZStack {
            title
            
            HStack {
                headerButton(iconName: "chevron.left", color: AppColor.textPrimary)
                
                Spacer()
                
                headerButton(iconName: "heart", color: Color.red)
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
    
    private func headerButton(iconName: String, color: Color) -> some View {
        Button(action: {}) {
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
    MovieDetailView()
}
