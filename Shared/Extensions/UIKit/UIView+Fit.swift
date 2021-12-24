//
//  UIView+Fit.swift
//  Shared
//
//  Copyright (c) 2018 Justin Peckner
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

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
