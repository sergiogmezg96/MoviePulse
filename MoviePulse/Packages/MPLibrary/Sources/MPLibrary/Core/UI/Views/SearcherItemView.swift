//
//  SearcherItemView.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 08/10/2026.
//

import SwiftUI

public struct SearcherItemViewConfig {
    let placeholder: String
    let text: Binding<String>
    let cornerRadius: CGFloat
    let padding: CGFloat
    let backgroundColor: Color
    let borderColor: Color
    let leftIcon: String?
    let rightIcon: String?
    let lineWidth: CGFloat
    
    public init(
        placeholder: String,
        text: Binding<String>,
        cornerRadius: CGFloat = CustomSize.size8,
        padding: CGFloat = CustomSize.size10,
        backgroundColor: Color = AppColor.background,
        borderColor: Color = AppColor.primary,
        leftIcon: String? = nil,
        rightIcon: String? = nil,
        lineWidth: CGFloat = 2
    ) {
        self.placeholder = placeholder
        self.text = text
        self.cornerRadius = cornerRadius
        self.padding = padding
        self.backgroundColor = backgroundColor
        self.borderColor = borderColor
        self.leftIcon = leftIcon
        self.rightIcon = rightIcon
        self.lineWidth = lineWidth
    }
}

public struct SearcherItemView: View {
    let config: SearcherItemViewConfig
    
    public init(config: SearcherItemViewConfig) {
        self.config = config
    }
    
    public var body: some View {
        HStack(spacing: CustomSize.size4) {
            if let leftIcon = config.leftIcon {
                Image(systemName: leftIcon)
                    .foregroundStyle(.white)
            }

            TextField(
                "",
                text: config.text,
                prompt: Text(config.placeholder)
                    .foregroundStyle(AppColor.textPrimary)
            )
            .textFieldStyle(.plain) // elimina el fondo negro nativo
            .foregroundStyle(AppColor.textPrimary)

            if let rightIcon = config.rightIcon {
                Image(systemName: rightIcon)
                    .foregroundStyle(.white)
            }
        }
        .padding(config.padding)
        .background(
            RoundedRectangle(
                cornerRadius: config.cornerRadius,
                style: .continuous
            )
            .fill(config.backgroundColor)
        )
        .overlay(
            RoundedRectangle(
                cornerRadius: config.cornerRadius,
                style: .continuous
            )
            .stroke(config.borderColor, lineWidth: 2)
        )
    }
}

#Preview {
    VStack {
        Spacer()
        
        SearcherItemView(
            config: SearcherItemViewConfig(
                placeholder: "Escribe aquí...",
                text: .constant(""),
                leftIcon: "magnifyingglass",
                rightIcon: "mic.fill"
            )
        )
        .padding()
        
        Spacer()
    }
    .background(AppColor.background.opacity(0.95))
}
