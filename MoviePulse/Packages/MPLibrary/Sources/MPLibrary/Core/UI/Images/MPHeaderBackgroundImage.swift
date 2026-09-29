//
//  MPHeaderBackgroundImage.swift
//  MPLibrary
//
//  Created by Sergio Gómez García on 29/09/2026.
//

import SwiftUI

public struct MPHeaderBackgroundImageConfig {
    let imageURL: URL?
    let imageName: String?
    let height: CGFloat
    let contentMode: ContentMode
    let gradientColors: [Color]
    let gradientStartPoint: UnitPoint
    let gradientEndPoint: UnitPoint
    let placeholderIconName: String

    public init(
        imageURL: URL?,
        imageName: String? = nil,
        height: CGFloat = 260,
        contentMode: ContentMode = .fill,
        gradientColors: [Color] = [
            .clear,
            AppColor.background.opacity(0.35),
            AppColor.background.opacity(0.95)
        ],
        gradientStartPoint: UnitPoint = .top,
        gradientEndPoint: UnitPoint = .bottom,
        placeholderIconName: String = "film"
    ) {
        self.imageURL = imageURL
        self.imageName = imageName
        self.height = height
        self.contentMode = contentMode
        self.gradientColors = gradientColors
        self.gradientStartPoint = gradientStartPoint
        self.gradientEndPoint = gradientEndPoint
        self.placeholderIconName = placeholderIconName
    }
}

public struct MPHeaderBackgroundImage: View {
    let config: MPHeaderBackgroundImageConfig

    public init(config: MPHeaderBackgroundImageConfig) {
        self.config = config
    }

    public var body: some View {
        VStack(spacing: CustomSize.size0) {
            MPRemoteImage(
                config: MPRemoteImageConfig(
                    imageURL: config.imageURL,
                    imageName: config.imageName,
                    contentMode: config.contentMode,
                    placeholderIconName: config.placeholderIconName
                )
            )
            .frame(maxWidth: .infinity)
            .frame(height: config.height)
            .clipped()
            .overlay {
                LinearGradient(
                    colors: config.gradientColors,
                    startPoint: config.gradientStartPoint,
                    endPoint: config.gradientEndPoint
                )
            }
        }
    }
}
