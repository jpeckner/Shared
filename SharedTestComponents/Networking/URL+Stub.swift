//
//  URL+Stub.swift
//  SharedTestComponents
//
//  Created by Justin Peckner.
//  Copyright © 2018 Justin Peckner. All rights reserved.
//

import Foundation

public extension URL {

    // swiftlint:disable force_unwrapping
    static func stubValue(string: String = "www.example.com") -> URL {
        return URL(string: string)!
    }
    // swiftlint:enable force_unwrapping

}
