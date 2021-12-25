//
//  UIColor+Dynamic.swift
//  Shared
//
//  Copyright (c) 2019 Justin Peckner
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
