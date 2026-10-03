//
//  MPRemoteImage.swift
//  MPLibrary
//
//  Created by Sergio Gómez García on 29/09/2026.
//

import SwiftUI

public struct MPRemoteImageConfig {
    let imageURL: URL?
    let imageName: String?
    let contentMode: ContentMode
    let placeholderBackgroundColor: Color
    let placeholderIconName: String
    let placeholderIconColor: Color
    let placeholderIconFont: Font

    public init(
        imageURL: URL?,
        imageName: String? = nil,
        contentMode: ContentMode = .fill,
        placeholderBackgroundColor: Color = AppColor.surfaceElevated,
        placeholderIconName: String = "film",
        placeholderIconColor: Color = AppColor.textSecondary,
        placeholderIconFont: Font = FontSize.title2
    ) {
        self.imageURL = imageURL
        self.imageName = imageName
        self.contentMode = contentMode
        self.placeholderBackgroundColor = placeholderBackgroundColor
        self.placeholderIconName = placeholderIconName
        self.placeholderIconColor = placeholderIconColor
        self.placeholderIconFont = placeholderIconFont
    }
}

public struct MPRemoteImage: View {
    let config: MPRemoteImageConfig

    public init(config: MPRemoteImageConfig) {
        self.config = config
    }

    @ViewBuilder
    public var body: some View {
        if let imageName = config.imageName {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: config.contentMode)
        } else if let imageURL = config.imageURL {
            AsyncImage(url: imageURL) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: config.contentMode)
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

    @ViewBuilder
    private var placeholder: some View {
        ZStack {
            config.placeholderBackgroundColor

            Image(systemName: config.placeholderIconName)
                .font(config.placeholderIconFont)
                .foregroundColor(config.placeholderIconColor)
        }
    }
}
