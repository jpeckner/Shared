//
//  UIColor+Dynamic.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

import UIKit

public extension UIColor {

    static func label(alternative: UIColor) -> UIColor {
        if #available(iOS 13.0, *) {
            return .label
        } else {
            return alternative
        }
    }

    static func placeholderText(alternative: UIColor) -> UIColor {
        if #available(iOS 13.0, *) {
            return .placeholderText
        } else {
            return alternative
        }
    }

    static func systemBackground(alternative: UIColor) -> UIColor {
        if #available(iOS 13.0, *) {
            return .systemBackground
        } else {
            return alternative
        }
    }

    static func systemGray(alternative: UIColor) -> UIColor {
        if #available(iOS 13.0, *) {
            return .systemGray
        } else {
            return alternative
        }
    }

    static func systemGray3(alternative: UIColor) -> UIColor {
        if #available(iOS 13.0, *) {
            return .systemGray3
        } else {
            return alternative
        }
    }

    static func systemGray4(alternative: UIColor) -> UIColor {
        if #available(iOS 13.0, *) {
            return .systemGray4
        } else {
            return alternative
        }
    }

    static func systemGray5(alternative: UIColor) -> UIColor {
        if #available(iOS 13.0, *) {
            return .systemGray5
        } else {
            return alternative
        }
    }

}
