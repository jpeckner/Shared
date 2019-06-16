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

    // The type: param isn't strictly necessary, but it prevents Swift from inferring that T's type, when not explicitly
    // declared on the left-hand side of an assignment, is UIViewController.self (chances are that T is actually a
    // subclass of UIViewController).
    func setSingleChildIfNotPresent<T: UIViewController>(_ type: T.Type,
                                                         initBlock: () -> T,
                                                         addToViewBlock: (UIView) -> Void) -> T {
        guard let child = firstChild as? T else {
            let newChild = initBlock()
            setSingleChildController(newChild, addToViewBlock: addToViewBlock)
            return newChild
        }

        return child
    }

    func setSingleChildController(_ child: UIViewController,
                                  addToViewBlock: (UIView) -> Void) {
        children.first.map(removeChildController)

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
