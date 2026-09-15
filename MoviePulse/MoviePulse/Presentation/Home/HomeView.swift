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
        .padding(.horizontal, CustomSize.size24)
        .background(AppColor.background)
    }
}

private struct MovieGenresSection: View {
    
    var body: some View {
        LazyVStack {
            //TODO: MovieGenreItem
        }
    }
}

private struct DiscoverSection: View {
    
    var body: some View {
        VStack {
            RoundedRectangle(
                cornerRadius: CustomSize.size8,
                style: .continuous
            )
            .frame(height: 240)
            .foregroundStyle(AppColor.textSecondary)
            .overlay {
                VStack {
                    HStack {
                        VStack(spacing: CustomSize.size10) {
                            Text("The last horizon")
                            Text("The last horizon")
                            Text("The last horizon")
                        }
                        Spacer()
                    }
                    Spacer()
                    HStack(spacing: CustomSize.size8) {
                        MPButton(
                            config: MPButtonConfig(
                                style: .primary,
                                cornerRadius: CustomSize.size10,
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
                                font: FontSize.captionBold,
                                iconName: "plus",
                                text: "My List",
                                action: {}
                            )
                        )
                        Spacer()
                    }
                    //TODO: Do page indicator
                }
                .padding(CustomSize.size8)
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
        .padding(.bottom, CustomSize.size24)
    }
}

#Preview {
    HomeView(store: HomeStore())
}
