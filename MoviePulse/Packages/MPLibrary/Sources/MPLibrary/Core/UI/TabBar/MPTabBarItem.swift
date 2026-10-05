//
//  MPTabBarItem.swift
//  MPLibrary
//
//  Created by Sergio Gómez García on 15/09/2026.
//

import SwiftUI

public struct MPTabBarItemConfig {
    let title: String
    let icon: String
    let isSelected: Bool
    let selectedColor: Color
    let unselectedColor: Color
    let iconSize: CGFloat
    let textSize: Font
    let onTap: () -> Void
    
    public init(
        title: String,
        icon: String,
        isSelected: Bool,
        selectedColor: Color = AppColor.primary,
        unselectedColor: Color = AppColor.textSecondary,
        iconSize: CGFloat = CustomSize.size22,
        textSize: Font = FontSize.caption,
        onTap: @escaping () -> Void
    ) {
        self.title = title
        self.icon = icon
        self.isSelected = isSelected
        self.selectedColor = selectedColor
        self.unselectedColor = unselectedColor
        self.iconSize = iconSize
        self.textSize = textSize
        self.onTap = onTap
    }
}

public struct MPTabBarItem: View {
    let config: MPTabBarItemConfig
    
    public init(config: MPTabBarItemConfig) {
        self.config = config
    }
    
    public var body: some View {
        Button(action: config.onTap) {
            VStack(alignment: .center, spacing: CustomSize.size6) {
                Image(systemName: config.icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: config.iconSize, height: config.iconSize)
                    .foregroundColor(itemColor)
                
                Text(config.title)
                    .font(config.textSize)
                    .foregroundColor(itemColor)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, CustomSize.size10)
        }
        .buttonStyle(.plain)
    }
    
    private var itemColor: Color {
        config.isSelected ? config.selectedColor : config.unselectedColor
    }
}

#Preview {
    VStack(spacing: CustomSize.size14) {
        MPTabBarItem(
            config: MPTabBarItemConfig(
                title: "Title",
                icon: "play.fill",
                isSelected: true,
                onTap: {
                })
        )
        
        MPTabBarItem(
            config: MPTabBarItemConfig(
                title: "Title",
                icon: "play.fill",
                isSelected: false,
                onTap: {
                })
        )
    }
    .background(Color.black)
}
