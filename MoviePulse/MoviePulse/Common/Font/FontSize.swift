//
//  FontSize.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 13/09/2026.
//

import Foundation
import SwiftUI
import UIKit

enum FontSize {
    static var caption2: Font { Font.Size.caption2.font }
    static var caption2Semibold: Font { caption2(.semibold) }
    static var caption2Bold: Font { caption2(.bold) }

    static var caption: Font { Font.Size.caption.font }
    static var captionSemibold: Font { caption(.semibold) }
    static var captionBold: Font { caption(.bold) }

    static var footnote: Font { Font.Size.footnote.font }
    static var footnoteSemibold: Font { footnote(.semibold) }
    static var footnoteBold: Font { footnote(.bold) }

    static var subheadline: Font { Font.Size.subheadline.font }
    static var subheadlineSemibold: Font { subheadline(.semibold) }
    static var subheadlineBold: Font { subheadline(.bold) }

    static var callout: Font { Font.Size.callout.font }
    static var calloutSemibold: Font { callout(.semibold) }
    static var calloutBold: Font { callout(.bold) }

    static var body: Font { Font.Size.body.font }
    static var bodySemibold: Font { body(.semibold) }
    static var bodyBold: Font { body(.bold) }

    static var headline: Font { Font.Size.headline.font }
    static var headlineSemibold: Font { headline(.semibold) }
    static var headlineBold: Font { headline(.bold) }

    static var title3: Font { Font.Size.title3.font }
    static var title3Semibold: Font { title3(.semibold) }
    static var title3Bold: Font { title3(.bold) }

    static var title2: Font { Font.Size.title2.font }
    static var title2Semibold: Font { title2(.semibold) }
    static var title2Bold: Font { title2(.bold) }

    static var title: Font { Font.Size.title.font }
    static var titleSemibold: Font { title(.semibold) }
    static var titleBold: Font { title(.bold) }

    static var largeTitle: Font { Font.Size.largeTitle.font }
    static var largeTitleSemibold: Font { largeTitle(.semibold) }
    static var largeTitleBold: Font { largeTitle(.bold) }

    static func font(
        _ weight: Font.Weight = .regular,
        _ size: Font.Size,
        design: Font.Design = .default
    ) -> Font {
        size.font(weight: weight, design: design)
    }

    static func value(_ size: Font.Size) -> CGFloat {
        size.value
    }

    static func scaledValue(
        _ size: Font.Size,
        compatibleWith traitCollection: UITraitCollection? = nil
    ) -> CGFloat {
        size.scaledValue(compatibleWith: traitCollection)
    }

    static func caption2(_ weight: Font.Weight, design: Font.Design = .default) -> Font {
        Font.Size.caption2.font(weight: weight, design: design)
    }

    static func caption(_ weight: Font.Weight, design: Font.Design = .default) -> Font {
        Font.Size.caption.font(weight: weight, design: design)
    }

    static func footnote(_ weight: Font.Weight, design: Font.Design = .default) -> Font {
        Font.Size.footnote.font(weight: weight, design: design)
    }

    static func subheadline(_ weight: Font.Weight, design: Font.Design = .default) -> Font {
        Font.Size.subheadline.font(weight: weight, design: design)
    }

    static func callout(_ weight: Font.Weight, design: Font.Design = .default) -> Font {
        Font.Size.callout.font(weight: weight, design: design)
    }

    static func body(_ weight: Font.Weight, design: Font.Design = .default) -> Font {
        Font.Size.body.font(weight: weight, design: design)
    }

    static func headline(_ weight: Font.Weight, design: Font.Design = .default) -> Font {
        Font.Size.headline.font(weight: weight, design: design)
    }

    static func title3(_ weight: Font.Weight, design: Font.Design = .default) -> Font {
        Font.Size.title3.font(weight: weight, design: design)
    }

    static func title2(_ weight: Font.Weight, design: Font.Design = .default) -> Font {
        Font.Size.title2.font(weight: weight, design: design)
    }

    static func title(_ weight: Font.Weight, design: Font.Design = .default) -> Font {
        Font.Size.title.font(weight: weight, design: design)
    }

    static func largeTitle(_ weight: Font.Weight, design: Font.Design = .default) -> Font {
        Font.Size.largeTitle.font(weight: weight, design: design)
    }
}

extension Font {
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
