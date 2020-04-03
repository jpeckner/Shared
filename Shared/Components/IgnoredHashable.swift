//
//  IgnoredHashable.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

/// Use IgnoredHashable for types in which the wrapped value doesn't matter for Hashable purposes.
public struct IgnoredHashable<T> {
    public let value: T

    public init(_ value: T) {
        self.value = value
    }
}

extension IgnoredHashable: Equatable {

    public static func == (lhs: IgnoredHashable<T>, rhs: IgnoredHashable<T>) -> Bool {
        return true
    }

}

extension IgnoredHashable: Hashable {

    public func hash(into hasher: inout Hasher) {}

}
