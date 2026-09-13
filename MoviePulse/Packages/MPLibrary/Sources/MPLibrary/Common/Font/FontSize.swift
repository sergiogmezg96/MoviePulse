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
    public static var caption2: Font { Font.Size.caption2.font }
    public static var caption2Semibold: Font { caption2(.semibold) }
    public static var caption2Bold: Font { caption2(.bold) }

    public static var caption: Font { Font.Size.caption.font }
    public static var captionSemibold: Font { caption(.semibold) }
    public static var captionBold: Font { caption(.bold) }

    public static var footnote: Font { Font.Size.footnote.font }
    public static var footnoteSemibold: Font { footnote(.semibold) }
    public static var footnoteBold: Font { footnote(.bold) }

    public static var subheadline: Font { Font.Size.subheadline.font }
    public static var subheadlineSemibold: Font { subheadline(.semibold) }
    public static var subheadlineBold: Font { subheadline(.bold) }

    public static var callout: Font { Font.Size.callout.font }
    public static var calloutSemibold: Font { callout(.semibold) }
    public static var calloutBold: Font { callout(.bold) }

    public static var body: Font { Font.Size.body.font }
    public static var bodySemibold: Font { body(.semibold) }
    public static var bodyBold: Font { body(.bold) }

    public static var headline: Font { Font.Size.headline.font }
    public static var headlineSemibold: Font { headline(.semibold) }
    public static var headlineBold: Font { headline(.bold) }

    public static var title3: Font { Font.Size.title3.font }
    public static var title3Semibold: Font { title3(.semibold) }
    public static var title3Bold: Font { title3(.bold) }

    public static var title2: Font { Font.Size.title2.font }
    public static var title2Semibold: Font { title2(.semibold) }
    public static var title2Bold: Font { title2(.bold) }

    public static var title: Font { Font.Size.title.font }
    public static var titleSemibold: Font { title(.semibold) }
    public static var titleBold: Font { title(.bold) }

    public static var largeTitle: Font { Font.Size.largeTitle.font }
    public static var largeTitleSemibold: Font { largeTitle(.semibold) }
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
        case caption2 = 10
        case caption = 12
        case footnote = 14
        case subheadline = 16
        case callout = 18
        case body = 20
        case headline = 22
        case title3 = 24
        case title2 = 26
        case title = 28
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
