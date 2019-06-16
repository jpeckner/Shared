//
//  UIView+Fit.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2018 Justin Peckner. All rights reserved.
//

import UIKit

// MARK: HorizontalAnchoringProtocol

public protocol HorizontalAnchoringProtocol {
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
}

extension HorizontalAnchoringProtocol {

    func fitHorizontally(to anchoring: HorizontalAnchoringProtocol) {
        leadingAnchor.constraint(equalTo: anchoring.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: anchoring.trailingAnchor).isActive = true
    }

}

extension UIView: HorizontalAnchoringProtocol {}

extension UILayoutGuide: HorizontalAnchoringProtocol {}

// MARK: VerticalAnchoringProtocol

public protocol VerticalAnchoringProtocol {
    var topAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
}

extension VerticalAnchoringProtocol {

    func fitVertically(to anchoring: VerticalAnchoringProtocol) {
        topAnchor.constraint(equalTo: anchoring.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: anchoring.bottomAnchor).isActive = true
    }

}

extension UIView: VerticalAnchoringProtocol {}

extension UILayoutGuide: VerticalAnchoringProtocol {}

// MARK: UIView convenience methods

public extension UIView {

    func fitFully(to superview: UIView) {
        translatesAutoresizingMaskIntoConstraints = false

        fitHorizontally(to: superview)
        fitVertically(to: superview)
    }

    func fitSafely(to superview: UIView) {
        translatesAutoresizingMaskIntoConstraints = false

        fitHorizontally(to: superview.safeAreaLayoutGuide)
        fitVertically(to: superview.safeAreaLayoutGuide)
    }

}
