//
//  TabItemProperties.swift
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

public struct TabItemProperties {
    let image: UIImage

    public init(image: UIImage) {
        self.image = image
    }
}

public extension UIViewController {

    func configure(properties: TabItemProperties) {
        tabBarItem.image = properties.image.withRenderingMode(.alwaysTemplate)
    }

}

public extension UITabBarController {

    // Concept for method from https://stackoverflow.com/a/46392579/1342984
    func adjustTabImageInsets(_ horizontalSizeClass: SpecifiedSizeClass) {
        if #available(iOS 26.0, *) {
            // In iOS 26+, the tab bar insets are set automatically
            return
        }

        tabBar.items?.forEach { item in
            switch horizontalSizeClass {
            case .compact:
                item.imageInsets = UIEdgeInsets(
                    top: 6.0,
                    left: 0.0,
                    bottom: -6.0,
                    right: 0.0
                )

            case .regular:
                item.imageInsets = .zero
            }
        }
    }

}
