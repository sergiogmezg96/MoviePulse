//
//  MPTabBar.swift
//  MPLibrary
//
//  Created by Sergio Gómez García on 15/09/2026.
//

import SwiftUI

public struct MPTabBarConfig {
    let tabBarItems: [MPTabBarItemConfig]
    let backgroundColor: Color
    let borderColor: Color
    let borderWidth: CGFloat
    let horizontalPadding: CGFloat
    let topPadding: CGFloat
    let bottomPadding: CGFloat
    
    public init(
        tabBarItems: [MPTabBarItemConfig],
        backgroundColor: Color = AppColor.background,
        borderColor: Color = AppColor.border,
        borderWidth: CGFloat = BorderSize.extraSmall,
        horizontalPadding: CGFloat = CustomSize.size12,
        topPadding: CGFloat = CustomSize.size8,
        bottomPadding: CGFloat = CustomSize.size24
    ) {
        self.tabBarItems = tabBarItems
        self.backgroundColor = backgroundColor
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.horizontalPadding = horizontalPadding
        self.topPadding = topPadding
        self.bottomPadding = bottomPadding
    }
}

public struct MPTabBar: View {
    let config: MPTabBarConfig
    
    public init(config: MPTabBarConfig) {
        self.config = config
    }
    
    public var body: some View {
        HStack(alignment: .center, spacing: CustomSize.size0) {
            ForEach(Array(config.tabBarItems.enumerated()), id: \.offset) { _, itemConfig in
                MPTabBarItem(config: itemConfig)
            }
        }
        .padding(.horizontal, config.horizontalPadding)
        .padding(.top, config.topPadding)
        .padding(.bottom, config.bottomPadding)
        .background(config.backgroundColor)
        .overlay(alignment: .top) {
            Rectangle()
                .fill(config.borderColor)
                .frame(height: config.borderWidth)
        }
    }
}

#Preview {
    MPTabBar(
        config: MPTabBarConfig(
            tabBarItems: [
                MPTabBarItemConfig(
                    title: "Home",
                    icon: "house.fill",
                    isSelected: true,
                    onTap: {}
                ),
                MPTabBarItemConfig(
                    title: "Browse",
                    icon: "movieclapper",
                    isSelected: false,
                    onTap: {}
                ),
                MPTabBarItemConfig(
                    title: "My List",
                    icon: "tv",
                    isSelected: false,
                    onTap: {}
                ),
                MPTabBarItemConfig(
                    title: "Downloads",
                    icon: "arrow.down.to.line",
                    isSelected: false,
                    onTap: {}
                )
            ]
        )
    )
    .background(AppColor.background)
}
