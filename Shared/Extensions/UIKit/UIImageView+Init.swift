//
//  UIImageView+Init.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

import UIKit

public extension UIImageView {

    convenience init(widthConstrainedImage: UIImage) {
        self.init(image: widthConstrainedImage)

        alignProportions(with: widthConstrainedImage)
    }

}
