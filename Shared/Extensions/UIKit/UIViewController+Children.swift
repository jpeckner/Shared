//
//  UIViewController+Children.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2018 Justin Peckner. All rights reserved.
//

import UIKit

public extension UIViewController {

    var firstChild: UIViewController? {
        return children.first
    }

    func setSingleChildController(_ child: UIViewController,
                                  addToViewBlock: (UIView) -> Void) {
        firstChild.map(removeChildController)

        addChild(child)
        addToViewBlock(child.view)
        child.didMove(toParent: self)
    }

    func removeChildController(_ child: UIViewController) {
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }

}
