//
//  NonEmptyArray.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

import Foundation

public struct NonEmptyArray<T> {
    public let value: [T]

    public init(with instance: T) {
        self.init(value: [instance])
    }

    public init?(_ value: [T]) {
        guard !value.isEmpty else { return nil }
        self.init(value: value)
    }

    private init(value: [T]) {
        self.value = value
    }
}

extension NonEmptyArray: Equatable where T: Equatable {}

extension NonEmptyArray: Hashable where T: Hashable {}

public extension NonEmptyArray {

    var first: T {
        return value[0]
    }

    var last: T {
        return value[value.count - 1]
    }

    func replacingLast(with element: T) -> NonEmptyArray<T> {
        return NonEmptyArray(value: Array(value.dropLast()) + [element])
    }

    func appendedWith(_ otherArray: [T]) -> NonEmptyArray<T> {
        return NonEmptyArray(value: value + otherArray)
    }

    func sorted(by block: (T, T) -> Bool) -> NonEmptyArray<T> {
        return NonEmptyArray(value: value.sorted(by: block))
    }

    func withTransformation<N>(transform: (T) -> N) -> NonEmptyArray<N> {
        let transformedValue = value.map(transform)
        return NonEmptyArray<N>(value: transformedValue)
    }

}
