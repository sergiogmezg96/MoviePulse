//
//  CustomPadding.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 13/09/2026.
//

import SwiftUI

public enum CustomPadding {
    public static let none: CGFloat = 0
    public static let extraSmall: CGFloat = 4
    public static let small: CGFloat = 8
    public static let medium: CGFloat = 16
    public static let large: CGFloat = 24
    public static let extraLarge: CGFloat = 32
    public static let extraExtraLarge: CGFloat = 40

    public static func all(_ value: CGFloat) -> EdgeInsets {
        EdgeInsets(top: value, leading: value, bottom: value, trailing: value)
    }

    public static func horizontal(_ value: CGFloat) -> EdgeInsets {
        EdgeInsets(top: none, leading: value, bottom: none, trailing: value)
    }

    public static func vertical(_ value: CGFloat) -> EdgeInsets {
        EdgeInsets(top: value, leading: none, bottom: value, trailing: none)
    }

    public static func custom(
        top: CGFloat = none,
        leading: CGFloat = none,
        bottom: CGFloat = none,
        trailing: CGFloat = none
    ) -> EdgeInsets {
        EdgeInsets(top: top, leading: leading, bottom: bottom, trailing: trailing)
    }
}
