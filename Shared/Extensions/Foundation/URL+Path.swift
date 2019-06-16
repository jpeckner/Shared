//
//  URL+Path.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

import Foundation

public extension URL {

    var pathComponentsSansSlash: [String] {
        if pathComponents.first == "/" {
            return Array(pathComponents.dropFirst())
        }

        return pathComponents
    }

}
