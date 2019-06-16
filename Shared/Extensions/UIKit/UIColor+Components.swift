//
//  UIColor+Components.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

import UIKit

public struct ColorComponents {
    public let red: CGFloat
    public let green: CGFloat
    public let blue: CGFloat
    public let alpha: CGFloat
}

public extension UIColor {

    var colorComponents: ColorComponents {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return ColorComponents(red: red,
                               green: green,
                               blue: blue,
                               alpha: alpha)
    }

    // Adapted from https://medium.com/@druchtie/contrast-calculator-with-yiq-5be69e55535c
    var isLight: Bool {
        let components = colorComponents
        let yiq = ((components.red * 299) + (components.green * 587) + (components.blue * 114)) / 1000
        return yiq >= 0.5
    }

}
