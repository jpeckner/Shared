//
//  TextLayout.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2018 Justin Peckner. All rights reserved.
//

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
