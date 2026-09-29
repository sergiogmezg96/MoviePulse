//
//  MPSelectableChip.swift
//  MPLibrary
//
//  Created by Sergio Gómez García on 29/09/2026.
//

import SwiftUI

public struct MPSelectableChipConfig {
    let title: String
    let isSelected: Bool
    let selectedForegroundColor: Color
    let selectedBorderColor: Color
    let selectedBackgroundColor: Color
    let unselectedForegroundColor: Color
    let unselectedBorderColor: Color
    let unselectedBackgroundColor: Color
    let font: Font
    let horizontalPadding: CGFloat
    let verticalPadding: CGFloat
    let cornerRadius: CGFloat
    let borderWidth: CGFloat
    let action: () -> Void

    public init(
        title: String,
        isSelected: Bool,
        selectedForegroundColor: Color = AppColor.primary,
        selectedBorderColor: Color = AppColor.primary,
        selectedBackgroundColor: Color = AppColor.primary.opacity(0.12),
        unselectedForegroundColor: Color = AppColor.textSecondary,
        unselectedBorderColor: Color = AppColor.border,
        unselectedBackgroundColor: Color = AppColor.background.opacity(0.45),
        font: Font = FontSize.footnoteSemibold,
        horizontalPadding: CGFloat = CustomSize.size18,
        verticalPadding: CGFloat = CustomSize.size10,
        cornerRadius: CGFloat = CustomSize.size18,
        borderWidth: CGFloat = BorderSize.small,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.isSelected = isSelected
        self.selectedForegroundColor = selectedForegroundColor
        self.selectedBorderColor = selectedBorderColor
        self.selectedBackgroundColor = selectedBackgroundColor
        self.unselectedForegroundColor = unselectedForegroundColor
        self.unselectedBorderColor = unselectedBorderColor
        self.unselectedBackgroundColor = unselectedBackgroundColor
        self.font = font
        self.horizontalPadding = horizontalPadding
        self.verticalPadding = verticalPadding
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
        self.action = action
    }
}

public struct MPSelectableChip: View {
    let config: MPSelectableChipConfig

    public init(config: MPSelectableChipConfig) {
        self.config = config
    }

    public var body: some View {
        Button(action: config.action) {
            Text(config.title)
                .font(config.font)
                .foregroundColor(foregroundColor)
                .lineLimit(1)
                .minimumScaleFactor(0.85)
                .padding(.horizontal, config.horizontalPadding)
                .padding(.vertical, config.verticalPadding)
                .frame(maxWidth: .infinity)
                .background(backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: config.cornerRadius))
                .overlay {
                    RoundedRectangle(cornerRadius: config.cornerRadius)
                        .stroke(borderColor, lineWidth: config.borderWidth)
                }
        }
        .buttonStyle(.plain)
    }

    private var foregroundColor: Color {
        config.isSelected ? config.selectedForegroundColor : config.unselectedForegroundColor
    }

    private var backgroundColor: Color {
        config.isSelected ? config.selectedBackgroundColor : config.unselectedBackgroundColor
    }

    private var borderColor: Color {
        config.isSelected ? config.selectedBorderColor : config.unselectedBorderColor
    }
}

#Preview {
    HStack(spacing: CustomSize.size8) {
        MPSelectableChip(
            config: MPSelectableChipConfig(
                title: "Movies & Series",
                isSelected: true,
                action: {}
            )
        )

        MPSelectableChip(
            config: MPSelectableChipConfig(
                title: "Top Rated",
                isSelected: false,
                action: {}
            )
        )
    }
    .padding()
    .background(AppColor.background)
}
