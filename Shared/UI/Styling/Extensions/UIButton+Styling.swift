//
//  UIButton+Styling.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

import UIKit

public extension UIButton {

    func applyTextLayout(_ textLayout: TextLayout) {
        titleLabel?.applyTextLayout(textLayout)
    }

    func applyTextColoring(_ textColoring: TextColoring,
                           for state: UIControl.State = .normal) {
        setTitleColor(textColoring.textColor, for: state)
    }

}
