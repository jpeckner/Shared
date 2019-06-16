//
//  IgnoredEquatable.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

import Foundation

/// Use IgnoredEquatable for types in which the wrapped value doesn't matter for Equatable purposes.
public struct IgnoredEquatable<T> {
    public let value: T

    public init(_ value: T) {
        self.value = value
    }
}

extension IgnoredEquatable: Equatable {

    public static func == (lhs: IgnoredEquatable<T>, rhs: IgnoredEquatable<T>) -> Bool {
        return true
    }

}
