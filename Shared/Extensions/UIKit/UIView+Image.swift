//
//  UIView+Image.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

import UIKit

public extension UIView {

    func alignProportions(with image: UIImage) {
        widthAnchor.constraint(equalTo: heightAnchor, multiplier: image.widthToHeightRatio).isActive = true
    }

}
