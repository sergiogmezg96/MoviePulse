//
//  MPMovieGridItem.swift
//  MPLibrary
//
//  Created by Sergio Gómez García on 29/09/2026.
//

import SwiftUI

public struct MPMovieGridItemConfig {
    let imageURL: URL?
    let imageName: String?
    let title: String
    let releaseDate: String
    let rating: String
    let imageAspectRatio: CGFloat
    let imageCornerRadius: CGFloat
    let titleFont: Font
    let metadataFont: Font
    let ratingIconName: String
    let ratingIconColor: Color
    let action: () -> Void

    public init(
        imageURL: URL? = nil,
        imageName: String? = nil,
        title: String,
        releaseDate: String,
        rating: String,
        imageAspectRatio: CGFloat = 16 / 9,
        imageCornerRadius: CGFloat = CustomSize.size8,
        titleFont: Font = FontSize.subheadlineBold,
        metadataFont: Font = FontSize.footnote,
        ratingIconName: String = "star.fill",
        ratingIconColor: Color = AppColor.warning,
        action: @escaping () -> Void
    ) {
        self.imageURL = imageURL
        self.imageName = imageName
        self.title = title
        self.releaseDate = releaseDate
        self.rating = rating
        self.imageAspectRatio = imageAspectRatio
        self.imageCornerRadius = imageCornerRadius
        self.titleFont = titleFont
        self.metadataFont = metadataFont
        self.ratingIconName = ratingIconName
        self.ratingIconColor = ratingIconColor
        self.action = action
    }
}

public struct MPMovieGridItem: View {
    let config: MPMovieGridItemConfig

    public init(config: MPMovieGridItemConfig) {
        self.config = config
    }

    public var body: some View {
        Button(action: config.action) {
            VStack(alignment: .leading, spacing: CustomSize.size8) {
                MPRemoteImage(
                    config: MPRemoteImageConfig(
                        imageURL: config.imageURL,
                        imageName: config.imageName
                    )
                )
                .frame(maxWidth: .infinity)
                .aspectRatio(config.imageAspectRatio, contentMode: .fit)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: config.imageCornerRadius))
                .overlay {
                    RoundedRectangle(cornerRadius: config.imageCornerRadius)
                        .stroke(AppColor.border, lineWidth: BorderSize.extraSmall)
                }

                VStack(alignment: .leading, spacing: CustomSize.size4) {
                    Text(config.title)
                        .font(config.titleFont)
                        .foregroundColor(AppColor.textPrimary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.85)

                    HStack(spacing: CustomSize.size6) {
                        Text(config.releaseDate)
                            .lineLimit(1)

                        Text("·")

                        HStack(spacing: CustomSize.size2) {
                            Text(config.rating)
                                .lineLimit(1)

                            Image(systemName: config.ratingIconName)
                                .font(FontSize.caption2)
                                .foregroundColor(config.ratingIconColor)
                        }
                    }
                    .font(config.metadataFont)
                    .foregroundColor(AppColor.textSecondary)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    LazyVGrid(
        columns: [
            GridItem(.flexible(), spacing: CustomSize.size14),
            GridItem(.flexible(), spacing: CustomSize.size14)
        ],
        spacing: CustomSize.size16
    ) {
        MPMovieGridItem(
            config: MPMovieGridItemConfig(
                imageName: "the-last",
                title: "The Last Horizon",
                releaseDate: "2026",
                rating: "9.8",
                action: {}
            )
        )

        MPMovieGridItem(
            config: MPMovieGridItemConfig(
                imageName: "the-last",
                title: "Orbital Drift",
                releaseDate: "2024",
                rating: "8.7",
                action: {}
            )
        )
    }
    .padding()
    .background(AppColor.background)
}
