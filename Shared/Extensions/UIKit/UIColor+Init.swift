//
//  UIColor+Convenience.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2018 Justin Peckner. All rights reserved.
//

import Foundation
import UIKit

enum UIColorInitError: Error {
    case invalidHexString(String)
}

public extension UIColor {

    convenience init(hexString: String) throws {
        guard let intValue = UInt(hexString.deletingPrefix("0x"), radix: 16),
            intValue <= 0xFFFFFF
        else {
            throw UIColorInitError.invalidHexString(hexString)
        }

        self.init(red: CGFloat((intValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((intValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(intValue & 0x0000FF) / 255.0,
                  alpha: 1.0)
    }

}
