//
//  NSTextAlignment+TextAlignment.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
public extension NSTextAlignment {

    var textAlignment: TextAlignment {
        switch self {
        case .left, .natural:
            return .leading
        case .center, .justified:
            return .center
        case .right:
            return .trailing
        @unknown default:
            fatalError("Unknown NSTextAlignment case: \(self)")
        }
    }

}
