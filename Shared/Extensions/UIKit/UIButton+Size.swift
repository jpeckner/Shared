//
//  UIButton+Size.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

import UIKit

public extension UIButton {

    // Unfortunately, contentEdgeInsets doesn't always work as advertised, so use this as a workaround if needed
    func constrainHeightToTitleLabel() {
        titleLabel.map {
            let compressedHeight = $0.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
            heightAnchor.constraint(equalToConstant: compressedHeight).isActive = true
        }
    }

}
