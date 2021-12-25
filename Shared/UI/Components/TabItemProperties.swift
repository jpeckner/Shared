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
    let imageName: String

    public init(imageName: String) {
        self.imageName = imageName
    }
}

public extension UIViewController {

    // https://developer.apple.com/design/human-interface-guidelines/ios/icons-and-images/custom-icons/ lists specific
    // heights to use at the URL below, but using them with vector images, such as
    // https://stackoverflow.com/a/37627080/1342984 describes, results in the images being too small. Using 32x32 tab
    // icons displays the desired size correctly on all current iPhones and iPads.
    private static let tabImageSize = CGSize(width: 32.0, height: 32.0)

    func configure(_ properties: TabItemProperties) {
        guard let image = UIImage(named: properties.imageName) else { return }

        let templateImage = image.withRenderingMode(.alwaysTemplate)
        tabBarItem.image = templateImage.with(size: UIViewController.tabImageSize)
    }

}

public extension UITabBarController {

    // Concept for method from https://stackoverflow.com/a/46392579/1342984
    func adjustTabImageInsets(_ horizontalSizeClass: SpecifiedSizeClass) {
        tabBar.items?.forEach {
            switch horizontalSizeClass {
            case .compact:
                $0.imageInsets = UIEdgeInsets(top: 6.0, left: 0.0, bottom: -6.0, right: 0.0)
            case .regular:
                $0.imageInsets = .zero
            }
        }
    }

}
