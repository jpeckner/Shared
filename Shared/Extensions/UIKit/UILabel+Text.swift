//
//  UILabel+Text.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

import UIKit

public extension UILabel {

    var hasText: Bool {
        return text.map { !$0.isEmpty } ?? false
    }

    func adjustFontSizeToFitWidth(numberOfLines: Int = 1,
                                  minimumScaleFactor: CGFloat = 0.25) {
        self.adjustsFontSizeToFitWidth = true
        self.numberOfLines = numberOfLines
        self.minimumScaleFactor = minimumScaleFactor
    }

}
