//
//  SpecifiedSizeClass.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

import UIKit

public enum SpecifiedSizeClass {
    case compact
    case regular
}

public extension SpecifiedSizeClass {

    init?(uiSizeClass: UIUserInterfaceSizeClass) {
        switch uiSizeClass {
        case .compact:
            self = .compact
        case .regular:
            self = .regular
        case .unspecified:
            return nil
        @unknown default:
            fatalError("Unknown UIUserInterfaceSizeClass case: \(uiSizeClass)")
        }
    }

}

public extension UIViewController {

    var horizontalSpecifiedClass: SpecifiedSizeClass? {
        return SpecifiedSizeClass(uiSizeClass: traitCollection.horizontalSizeClass)
    }

}
