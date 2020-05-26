//
//  StyledText.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
public struct StyledText: View {
    @State public var text: String
    @State public var font: Font
    @State public var alignment: TextAlignment
    @State public var textColoring: TextColoring

    public init(text: String,
                font: Font,
                alignment: TextAlignment,
                textColoring: TextColoring) {
        self._text = State(initialValue: text)
        self._font = State(initialValue: font)
        self._alignment = State(initialValue: alignment)
        self._textColoring = State(initialValue: textColoring)
    }

    public var body: some View {
        Text(text)
            .font(font)
            .multilineTextAlignment(alignment)
            .foregroundColor(Color(textColoring.textColor))
    }
}
