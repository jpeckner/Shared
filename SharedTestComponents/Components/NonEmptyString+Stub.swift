//
//  NonEmptyString+Stub.swift
//  SharedTestComponents
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

import Foundation
import Shared

public extension NonEmptyString {

    // swiftlint:disable force_try
    static func stubValue(_ value: String = "StubNonEmptyStringValue") -> NonEmptyString {
        return try! NonEmptyString(value)
    }
    // swiftlint:enable force_try

}
