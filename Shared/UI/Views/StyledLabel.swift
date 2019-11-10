//
//  StyledLabel.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2018 Justin Peckner. All rights reserved.
//

import SwiftUI
import UIKit

public class StyledLabel: UILabel {

    public var textLayout: TextLayout {
        didSet {
            applyTextLayout(textLayout)
        }
    }

    public var textColoring: TextColoring {
        didSet {
            applyTextColoring(textColoring)
        }
    }

    public init(textLayout: TextLayout = TextLayout(font: UIFont.systemFont(ofSize: UIFont.systemFontSize),
                                                    alignment: .left),
                textColoring: TextColoring = TextColoring(textColor: .black),
                numberOfLines: Int = 0) {
        self.textLayout = textLayout
        self.textColoring = textColoring

        super.init(frame: .zero)

        self.numberOfLines = numberOfLines
        applyTextLayout(textLayout)
        applyTextColoring(textColoring)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: StyledLabelSUI

@available(iOS 13.0, *)
public struct StyledLabelSUI: View {
    @State public var text: String
    @State public var font: Font
    @State public var alignment: TextAlignment
    @State public var textColoring: TextColoring
    @State public var numberOfLines: Int?

    public init(text: String,
                font: Font,
                alignment: TextAlignment,
                textColoring: TextColoring,
                numberOfLines: Int? = nil) {
        self._text = State(initialValue: text)
        self._font = State(initialValue: font)
        self._alignment = State(initialValue: alignment)
        self._textColoring = State(initialValue: textColoring)
        self._numberOfLines = State(initialValue: numberOfLines)
    }

    public var body: some View {
        Text(text)
            .font(font)
            .multilineTextAlignment(alignment)
            .foregroundColor(Color(textColoring.textColor))
            .lineLimit(numberOfLines)
    }
}
