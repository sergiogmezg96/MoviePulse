//
//  FontSize.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 13/09/2026.
//

import Foundation
import SwiftUI
import UIKit

public enum FontSize {
    /// PointSize: 10
    public static var caption2: Font { Font.Size.caption2.font }
    /// PointSize: 10
    public static var caption2Semibold: Font { caption2(.semibold) }
    /// PointSize: 10
    public static var caption2Bold: Font { caption2(.bold) }

    /// PointSize: 12
    public static var caption: Font { Font.Size.caption.font }
    /// PointSize: 12
    public static var captionSemibold: Font { caption(.semibold) }
    /// PointSize: 12
    public static var captionBold: Font { caption(.bold) }

    /// PointSize: 14
    public static var footnote: Font { Font.Size.footnote.font }
    /// PointSize: 14
    public static var footnoteSemibold: Font { footnote(.semibold) }
    /// PointSize: 14
    public static var footnoteBold: Font { footnote(.bold) }

    /// PointSize: 16
    public static var subheadline: Font { Font.Size.subheadline.font }
    /// PointSize: 16
    public static var subheadlineSemibold: Font { subheadline(.semibold) }
    /// PointSize: 16
    public static var subheadlineBold: Font { subheadline(.bold) }

    /// PointSize: 18
    public static var callout: Font { Font.Size.callout.font }
    /// PointSize: 18
    public static var calloutSemibold: Font { callout(.semibold) }
    /// PointSize: 18
    public static var calloutBold: Font { callout(.bold) }

    /// PointSize: 20
    public static var body: Font { Font.Size.body.font }
    /// PointSize: 20
    public static var bodySemibold: Font { body(.semibold) }
    /// PointSize: 20
    public static var bodyBold: Font { body(.bold) }

    /// PointSize: 22
    public static var headline: Font { Font.Size.headline.font }
    /// PointSize: 22
    public static var headlineSemibold: Font { headline(.semibold) }
    /// PointSize: 22
    public static var headlineBold: Font { headline(.bold) }

    /// PointSize: 24
    public static var title3: Font { Font.Size.title3.font }
    /// PointSize: 24
    public static var title3Semibold: Font { title3(.semibold) }
    /// PointSize: 24
    public static var title3Bold: Font { title3(.bold) }

    /// PointSize: 26
    public static var title2: Font { Font.Size.title2.font }
    /// PointSize: 26
    public static var title2Semibold: Font { title2(.semibold) }
    /// PointSize: 26
    public static var title2Bold: Font { title2(.bold) }

    /// PointSize: 28
    public static var title: Font { Font.Size.title.font }
    /// PointSize: 28
    public static var titleSemibold: Font { title(.semibold) }
    /// PointSize: 28
    public static var titleBold: Font { title(.bold) }

    /// PointSize: 30
    public static var largeTitle: Font { Font.Size.largeTitle.font }
    /// PointSize: 30
    public static var largeTitleSemibold: Font { largeTitle(.semibold) }
    /// PointSize: 30
    public static var largeTitleBold: Font { largeTitle(.bold) }

    public static func font(
        _ weight: Font.Weight = .regular,
        _ size: Font.Size,
        design: Font.Design = .default
    ) -> Font {
        size.font(weight: weight, design: design)
    }

    public static func value(_ size: Font.Size) -> CGFloat {
        size.value
    }

    public static func scaledValue(
        _ size: Font.Size,
        compatibleWith traitCollection: UITraitCollection? = nil
    ) -> CGFloat {
        size.scaledValue(compatibleWith: traitCollection)
    }

    public static func caption2(_ weight: Font.Weight, design: Font.Design = .default) -> Font {
        Font.Size.caption2.font(weight: weight, design: design)
    }

    public static func caption(_ weight: Font.Weight, design: Font.Design = .default) -> Font {
        Font.Size.caption.font(weight: weight, design: design)
    }

    public static func footnote(_ weight: Font.Weight, design: Font.Design = .default) -> Font {
        Font.Size.footnote.font(weight: weight, design: design)
    }

    public static func subheadline(_ weight: Font.Weight, design: Font.Design = .default) -> Font {
        Font.Size.subheadline.font(weight: weight, design: design)
    }

    public static func callout(_ weight: Font.Weight, design: Font.Design = .default) -> Font {
        Font.Size.callout.font(weight: weight, design: design)
    }

    public static func body(_ weight: Font.Weight, design: Font.Design = .default) -> Font {
        Font.Size.body.font(weight: weight, design: design)
    }

    public static func headline(_ weight: Font.Weight, design: Font.Design = .default) -> Font {
        Font.Size.headline.font(weight: weight, design: design)
    }

    public static func title3(_ weight: Font.Weight, design: Font.Design = .default) -> Font {
        Font.Size.title3.font(weight: weight, design: design)
    }

    public static func title2(_ weight: Font.Weight, design: Font.Design = .default) -> Font {
        Font.Size.title2.font(weight: weight, design: design)
    }

    public static func title(_ weight: Font.Weight, design: Font.Design = .default) -> Font {
        Font.Size.title.font(weight: weight, design: design)
    }

    public static func largeTitle(_ weight: Font.Weight, design: Font.Design = .default) -> Font {
        Font.Size.largeTitle.font(weight: weight, design: design)
    }
}

public extension Font {
    enum Size: CGFloat, CaseIterable {
        /// PointSize: 10
        case caption2 = 10
        /// PointSize: 12
        case caption = 12
        /// PointSize: 14
        case footnote = 14
        /// PointSize: 16
        case subheadline = 16
        /// PointSize: 18
        case callout = 18
        /// PointSize: 20
        case body = 20
        /// PointSize: 22
        case headline = 22
        /// PointSize: 24
        case title3 = 24
        /// PointSize: 26
        case title2 = 26
        /// PointSize: 28
        case title = 28
        /// PointSize: 30
        case largeTitle = 30

        var textStyle: Font.TextStyle {
            switch self {
            case .caption2:
                return .caption2
            case .caption:
                return .caption
            case .footnote:
                return .footnote
            case .subheadline:
                return .subheadline
            case .callout:
                return .callout
            case .body:
                return .body
            case .headline:
                return .headline
            case .title3:
                return .title3
            case .title2:
                return .title2
            case .title:
                return .title
            case .largeTitle:
                return .largeTitle
            }
        }

        var uiTextStyle: UIFont.TextStyle {
            switch self {
            case .caption2:
                return .caption2
            case .caption:
                return .caption1
            case .footnote:
                return .footnote
            case .subheadline:
                return .subheadline
            case .callout:
                return .callout
            case .body:
                return .body
            case .headline:
                return .headline
            case .title3:
                return .title3
            case .title2:
                return .title2
            case .title:
                return .title1
            case .largeTitle:
                return .largeTitle
            }
        }

        var value: CGFloat {
            rawValue
        }

        var scaledValue: CGFloat {
            UIFontMetrics(forTextStyle: uiTextStyle).scaledValue(for: rawValue)
        }

        var font: Font {
            Font.customSize(self)
        }

        func scaledValue(compatibleWith traitCollection: UITraitCollection?) -> CGFloat {
            UIFontMetrics(forTextStyle: uiTextStyle)
                .scaledValue(for: rawValue, compatibleWith: traitCollection)
        }

        func font(
            weight: Font.Weight = .regular,
            design: Font.Design = .default
        ) -> Font {
            Font.customSize(self, weight: weight, design: design)
        }
    }

    static func customSize(
        _ size: Size,
        weight: Weight = .regular,
        design: Design = .default
    ) -> Font {
        .system(
            size: size.scaledValue,
            weight: weight,
            design: design
        )
    }
}
