//
//  UILabel+Styling.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

import UIKit

public extension UILabel {

    func applyTextLayout(_ textLayout: TextLayout) {
        font = textLayout.font
        textAlignment = textLayout.alignment
    }

    func applyTextColoring(_ textColoring: TextColoring) {
        textColor = textColoring.textColor
    }

}
