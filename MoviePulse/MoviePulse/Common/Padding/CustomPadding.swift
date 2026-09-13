//
//  CustomPadding.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 13/09/2026.
//

import SwiftUI

enum CustomPadding {
    static let none: CGFloat = 0
    static let extraSmall: CGFloat = 4
    static let small: CGFloat = 8
    static let medium: CGFloat = 16
    static let large: CGFloat = 24
    static let extraLarge: CGFloat = 32
    static let extraExtraLarge: CGFloat = 40

    static func all(_ value: CGFloat) -> EdgeInsets {
        EdgeInsets(top: value, leading: value, bottom: value, trailing: value)
    }

    static func horizontal(_ value: CGFloat) -> EdgeInsets {
        EdgeInsets(top: none, leading: value, bottom: none, trailing: value)
    }

    static func vertical(_ value: CGFloat) -> EdgeInsets {
        EdgeInsets(top: value, leading: none, bottom: value, trailing: none)
    }

    static func custom(
        top: CGFloat = none,
        leading: CGFloat = none,
        bottom: CGFloat = none,
        trailing: CGFloat = none
    ) -> EdgeInsets {
        EdgeInsets(top: top, leading: leading, bottom: bottom, trailing: trailing)
    }
}
