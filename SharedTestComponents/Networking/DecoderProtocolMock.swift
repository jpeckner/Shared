//
//  DecoderProtocolMock.swift
//  SharedTestComponents
//
//  Created by Justin Peckner.
//  Copyright © 2018 Justin Peckner. All rights reserved.
//

import Foundation
import Shared

// swiftlint:disable force_cast
// swiftlint:disable implicitly_unwrapped_optional
public class DecoderProtocolMock: DecoderProtocol {

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
        if let error = decodeFromThrowableError {
            throw error
        }

        decodeFromCallsCount += 1
        decodeFromReceivedArguments = (type: type, data: data)
        return try decodeFromClosure.map { try $0(type, data) } as? T ?? decodeFromReturnValue as! T
    }

}
