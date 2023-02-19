//
//  NonEmptyArray.swift
//  Shared
//
//  Copyright (c) 2019 Justin Peckner
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import Foundation

public struct NonEmptyArray<TElement> {
    public let value: [TElement]

    public init(with instance: TElement) {
        self.init(value: [instance])
    }

    public init?(_ value: [TElement]) {
        guard !value.isEmpty else { return nil }
        self.init(value: value)
    }

    private init(value: [TElement]) {
        self.value = value
    }
}

extension NonEmptyArray: Equatable where TElement: Equatable {}

extension NonEmptyArray: Hashable where TElement: Hashable {}

extension NonEmptyArray: Sendable where TElement: Sendable {}

public extension NonEmptyArray {

    var first: TElement {
        return value[0]
    }

    var last: TElement {
        return value[value.count - 1]
    }

    func replacingLast(with element: TElement) -> NonEmptyArray<TElement> {
        return NonEmptyArray(value: Array(value.dropLast()) + [element])
    }

    func appendedWith(_ otherArray: [TElement]) -> NonEmptyArray<TElement> {
        return NonEmptyArray(value: value + otherArray)
    }

    func sorted(by block: (TElement, TElement) -> Bool) -> NonEmptyArray<TElement> {
        return NonEmptyArray(value: value.sorted(by: block))
    }

    func withTransformation<N>(transform: (TElement) -> N) -> NonEmptyArray<N> {
        let transformedValue = value.map(transform)
        return NonEmptyArray<N>(value: transformedValue)
    }

}
