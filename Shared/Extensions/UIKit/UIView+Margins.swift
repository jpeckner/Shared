//
//  UIView+Margins.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2018 Justin Peckner. All rights reserved.
//

import UIKit

public extension UIView {

    func configureMargins(top: CGFloat,
                          leading: CGFloat,
                          bottom: CGFloat,
                          trailing: CGFloat) {
        directionalLayoutMargins = NSDirectionalEdgeInsets(top: top,
                                                           leading: leading,
                                                           bottom: bottom,
                                                           trailing: trailing)
    }

    func configureZeroInsetMargins() {
        configureMargins(top: 0.0,
                         leading: 0.0,
                         bottom: 0.0,
                         trailing: 0.0)
    }

}
