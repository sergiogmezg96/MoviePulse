//
//  CustomSize.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 13/09/2026.
//

import SwiftUI

public enum CustomSize {
    /// PointSize: 0
    public static let size0: CGFloat = 0
    /// PointSize: 2
    public static let size2: CGFloat = 2
    /// PointSize: 4
    public static let size4: CGFloat = 4
    /// PointSize: 6
    public static let size6: CGFloat = 6
    /// PointSize: 8
    public static let size8: CGFloat = 8
    /// PointSize: 10
    public static let size10: CGFloat = 10
    /// PointSize: 12
    public static let size12: CGFloat = 12
    /// PointSize: 14
    public static let size14: CGFloat = 14
    /// PointSize: 16
    public static let size16: CGFloat = 16
    /// PointSize: 18
    public static let size18: CGFloat = 18
    /// PointSize: 20
    public static let size20: CGFloat = 20
    /// PointSize: 22
    public static let size22: CGFloat = 22
    /// PointSize: 24
    public static let size24: CGFloat = 24
    /// PointSize: 26
    public static let size26: CGFloat = 26
    /// PointSize: 28
    public static let size28: CGFloat = 28
    /// PointSize: 30
    public static let size30: CGFloat = 30
    /// PointSize: 32
    public static let size32: CGFloat = 32
    /// PointSize: 34
    public static let size34: CGFloat = 34
    /// PointSize: 36
    public static let size36: CGFloat = 36
    /// PointSize: 38
    public static let size38: CGFloat = 38
    /// PointSize: 40
    public static let size40: CGFloat = 40

    /// Returns the same point size for all edges.
    public static func all(_ value: CGFloat) -> EdgeInsets {
        EdgeInsets(top: value, leading: value, bottom: value, trailing: value)
    }

    /// Returns the given point size for leading and trailing edges.
    public static func horizontal(_ value: CGFloat) -> EdgeInsets {
        EdgeInsets(top: size0, leading: value, bottom: size0, trailing: value)
    }

    /// Returns the given point size for top and bottom edges.
    public static func vertical(_ value: CGFloat) -> EdgeInsets {
        EdgeInsets(top: value, leading: size0, bottom: value, trailing: size0)
    }

    /// Returns custom point sizes for each edge.
    public static func custom(
        top: CGFloat = size0,
        leading: CGFloat = size0,
        bottom: CGFloat = size0,
        trailing: CGFloat = size0
    ) -> EdgeInsets {
        EdgeInsets(top: top, leading: leading, bottom: bottom, trailing: trailing)
    }
}
