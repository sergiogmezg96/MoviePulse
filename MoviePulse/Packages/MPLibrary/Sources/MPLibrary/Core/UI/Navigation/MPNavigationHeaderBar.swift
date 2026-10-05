//
//  MPNavigationHeaderBar.swift
//  MPLibrary
//
//  Created by Sergio Gómez García on 29/09/2026.
//

import SwiftUI

public struct MPNavigationHeaderBarConfig {
    let titlePrefix: String
    let titleSuffix: String
    let titlePrefixColor: Color
    let titleSuffixColor: Color
    let titleFont: Font
    let leadingIconName: String
    let leadingColor: Color
    let trailingIconName: String?
    let trailingColor: Color
    let buttonSize: CGFloat
    let buttonBackgroundColor: Color
    let horizontalPadding: CGFloat
    let bottomPadding: CGFloat
    let onLeadingTap: () -> Void
    let onTrailingTap: () -> Void

    public init(
        titlePrefix: String = "Movie",
        titleSuffix: String = "Pulse",
        titlePrefixColor: Color = AppColor.textPrimary,
        titleSuffixColor: Color = AppColor.primary,
        titleFont: Font = FontSize.headlineBold,
        leadingIconName: String = "chevron.left",
        leadingColor: Color = AppColor.textPrimary,
        trailingIconName: String? = nil,
        trailingColor: Color = AppColor.textPrimary,
        buttonSize: CGFloat = CustomSize.size32,
        buttonBackgroundColor: Color = AppColor.background.opacity(0.85),
        horizontalPadding: CGFloat = CustomSize.size24,
        bottomPadding: CGFloat = CustomSize.size24,
        onLeadingTap: @escaping () -> Void,
        onTrailingTap: @escaping () -> Void = {}
    ) {
        self.titlePrefix = titlePrefix
        self.titleSuffix = titleSuffix
        self.titlePrefixColor = titlePrefixColor
        self.titleSuffixColor = titleSuffixColor
        self.titleFont = titleFont
        self.leadingIconName = leadingIconName
        self.leadingColor = leadingColor
        self.trailingIconName = trailingIconName
        self.trailingColor = trailingColor
        self.buttonSize = buttonSize
        self.buttonBackgroundColor = buttonBackgroundColor
        self.horizontalPadding = horizontalPadding
        self.bottomPadding = bottomPadding
        self.onLeadingTap = onLeadingTap
        self.onTrailingTap = onTrailingTap
    }
}

public struct MPNavigationHeaderBar: View {
    let config: MPNavigationHeaderBarConfig

    public init(config: MPNavigationHeaderBarConfig) {
        self.config = config
    }

    public var body: some View {
        ZStack {
            title

            HStack {
                headerButton(
                    iconName: config.leadingIconName,
                    color: config.leadingColor,
                    action: config.onLeadingTap
                )

                Spacer()

                if let trailingIconName = config.trailingIconName {
                    headerButton(
                        iconName: trailingIconName,
                        color: config.trailingColor,
                        action: config.onTrailingTap
                    )
                }
            }
        }
        .padding(.horizontal, config.horizontalPadding)
        .padding(.bottom, config.bottomPadding)
    }

    private var title: some View {
        (
            Text(config.titlePrefix)
                .foregroundColor(config.titlePrefixColor)
            +
            Text(config.titleSuffix)
                .foregroundColor(config.titleSuffixColor)
        )
        .font(config.titleFont)
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
                .frame(width: config.buttonSize, height: config.buttonSize)
                .background(config.buttonBackgroundColor)
                .clipShape(Circle())
        }
        .buttonStyle(.plain)
    }
}
