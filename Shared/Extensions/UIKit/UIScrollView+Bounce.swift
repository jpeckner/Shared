//
//  UIScrollView+Bounce.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

import UIKit

// Code in this extension copied from https://stackoverflow.com/a/42951161/1342984
public extension UIScrollView {

    var isBouncingTop: Bool {
        return contentOffset.y.isLess(than: -contentInset.top)
    }

    var isBouncingBottom: Bool {
        let contentFillsScrollEdges = contentSize.height + contentInset.top + contentInset.bottom >= bounds.height
        return contentFillsScrollEdges && contentOffset.y > contentSize.height - bounds.height + contentInset.bottom
    }

}
