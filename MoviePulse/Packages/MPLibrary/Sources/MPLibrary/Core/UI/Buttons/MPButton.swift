//
//  MPButton.swift
//  MPLibrary
//
//  Created by Sergio Gómez García on 15/09/2026.
//

import SwiftUI

/// Available visual variants for `MPButton`.
public enum MPButtonStyle {
    case primary
    case secondary
}

public struct MPButtonConfig {
    let style: MPButtonStyle
    let cornerRadius: CGFloat
    let backgroundColor: Color
    let foregroundColor: Color
    let borderColor: Color
    let horizontalPadding: CGFloat
    let verticalPadding: CGFloat
    let borderWidth: CGFloat
    let font: Font
    let iconSize: CGFloat
    let iconName: String?
    let text: String
    let action: () -> Void
    
    /// Creates the configuration used to render an `MPButton`.
    ///
    /// - Parameters:
    ///   - style: Visual variant of the button. Use `.primary` for the main action and `.secondary` for outlined actions.
    ///   - cornerRadius: Button corner radius. Defaults to `CustomSize.size4`.
    ///   - backgroundColor: Optional custom background color. When `nil`, the selected `style` decides the color.
    ///   - foregroundColor: Optional custom text and icon color. When `nil`, the selected `style` decides the color.
    ///   - borderColor: Optional custom border color. When `nil`, the selected `style` decides the color.
    ///   - horizontalPadding: Horizontal content padding. For example, `24` adds 24 points on leading and trailing.
    ///   - verticalPadding: Vertical content padding. For example, `14` adds 14 points on top and bottom.
    ///   - borderWidth: Optional border width. When `nil`, the selected `style` decides the width.
    ///   - font: Text font used by the button title. Defaults to `FontSize.calloutSemibold`.
    ///   - iconSize: Optional left icon size in points. For example, `18` renders an 18-point SF Symbol.
    ///   - iconName: Optional SF Symbol name shown at the left side of the text. Use `nil` to hide the icon.
    ///   - text: Button title.
    ///   - action: Closure executed when the user taps the button.
    public init(
        style: MPButtonStyle = .primary,
        cornerRadius: CGFloat = CustomSize.size4,
        backgroundColor: Color? = nil,
        foregroundColor: Color? = nil,
        borderColor: Color? = nil,
        horizontalPadding: CGFloat = 24,
        verticalPadding: CGFloat = 14,
        borderWidth: CGFloat? = nil,
        font: Font = FontSize.calloutSemibold,
        iconSize: CGFloat = 18,
        iconName: String? = nil,
        text: String,
        action: @escaping () -> Void
    ) {
        let styleColors = Self.colors(for: style)
        self.style = style
        self.cornerRadius = cornerRadius
        self.backgroundColor = backgroundColor ?? styleColors.background
        self.foregroundColor = foregroundColor ?? styleColors.foreground
        self.borderColor = borderColor ?? styleColors.border
        self.horizontalPadding = horizontalPadding
        self.verticalPadding = verticalPadding
        self.borderWidth = borderWidth ?? styleColors.borderWidth
        self.font = font
        self.iconSize = iconSize
        self.iconName = iconName
        self.text = text
        self.action = action
    }
    
    private static func colors(for style: MPButtonStyle) -> (
        background: Color,
        foreground: Color,
        border: Color,
        borderWidth: CGFloat
    ) {
        switch style {
        case .primary:
            return (
                background: AppColor.primary,
                foreground: AppColor.background,
                border: .clear,
                borderWidth: BorderSize.none
            )
        case .secondary:
            return (
                background: .clear,
                foreground: AppColor.textPrimary,
                border: AppColor.border,
                borderWidth: BorderSize.small
            )
        }
    }
}

public struct MPButton: View {
    let config: MPButtonConfig
    
    public init(config: MPButtonConfig) {
        self.config = config
    }
    
    public var body: some View {
        Button(action: config.action) {
            HStack(spacing: 10) {
                if let iconName = config.iconName {
                    Image(systemName: iconName)
                        .font(.system(size: config.iconSize, weight: .semibold))
                }
                
                Text(config.text)
                    .font(config.font)
            }
            .foregroundColor(config.foregroundColor)
            .padding(.horizontal, config.horizontalPadding)
            .padding(.vertical, config.verticalPadding)
            .background(config.backgroundColor)
            .overlay(
                RoundedRectangle(cornerRadius: config.cornerRadius)
                    .stroke(config.borderColor, lineWidth: config.borderWidth)
            )
            .clipShape(RoundedRectangle(cornerRadius: config.cornerRadius))
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    HStack(spacing: CustomSize.size10) {
        MPButton(
            config: MPButtonConfig(
                style: .primary,
                iconName: "play.fill",
                text: "Play",
                action: {}
            )
        )
        
        MPButton(
            config: MPButtonConfig(
                style: .secondary,
                iconName: "plus",
                text: "My List",
                action: {}
            )
        )
    }
    .padding()
    .background(AppColor.background)
}
