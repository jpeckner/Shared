//
//  DecoderProtocolMock.swift
//  SharedTestComponents
//
//  Copyright (c) 2018 Justin Peckner
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
import Shared

// swiftlint:disable force_cast
// swiftlint:disable implicitly_unwrapped_optional
public class DecoderProtocolMock: DecoderProtocol, @unchecked Sendable {

    // MARK: - decode<T>

    public var decodeFromThrowableError: Error?
    public var decodeFromCallsCount = 0
    public var decodeFromCalled: Bool {
        return decodeFromCallsCount > 0
    }

    public var decodeFromReceivedArguments: (type: Decodable.Type, data: Data)?
    public var decodeFromReturnValue: Decodable!
    public var decodeFromClosure: ((Decodable.Type, Data) throws -> Decodable)?

    public init() {}

    public func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
        decodeFromCallsCount += 1
        decodeFromReceivedArguments = (type: type, data: data)

        if let error = decodeFromThrowableError {
            throw error
        }

        return try decodeFromClosure.map { try $0(type, data) } as? T ?? decodeFromReturnValue as! T
    }

}
