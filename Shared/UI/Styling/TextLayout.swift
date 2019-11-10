//
//  TextLayout.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2018 Justin Peckner. All rights reserved.
//

import SwiftUI
import UIKit

public struct TextLayout: Equatable {
    public let font: UIFont
    public let alignment: NSTextAlignment

    public init(font: UIFont,
                alignment: NSTextAlignment) {
        self.font = font
        self.alignment = alignment
    }
}

@available(iOS 13.0, *)
public extension Text {

    func applyTextLayout(_ textLayout: TextLayout) -> some View {
        return
            font(Font(textLayout.font.ctFont))
            .multilineTextAlignment(textLayout.alignment.textAlignment)
    }

    func applyTextColoring(_ textColoring: TextColoring) -> Text {
        return foregroundColor(Color(textColoring.textColor))
    }

}

public extension UIFont {

    var ctFont: CTFont {
        self as CTFont
    }

}

@available(iOS 13.0, *)
public extension NSTextAlignment {

    var textAlignment: TextAlignment {
        switch self {
        case .left, .natural:
            return .leading
        case .center, .justified:
            return .center
        case .right:
            return .trailing
        @unknown default:
            fatalError("Unknown NSTextAlignment case: \(self)")
        }
    }

}
