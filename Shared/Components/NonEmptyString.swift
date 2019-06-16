//
//  NonEmptyString.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

import Foundation

public enum NonEmptyStringError: Error {
    case initValueEmpty
}

public struct NonEmptyString: Hashable {
    public let value: String

    public init(_ value: String) throws {
        guard !value.isEmpty else { throw NonEmptyStringError.initValueEmpty }
        self.value = value
    }
}

extension NonEmptyString: Decodable {

    public init(from decoder: Decoder) throws {
        let value = try decoder.singleValueContainer().decode(String.self)
        try self.init(value)
    }

}

private extension NonEmptyString {

    init(knownNonEmptyValue: String) {
        self.value = knownNonEmptyValue
    }

}

// MARK: NonEmptyArray extension

public extension NonEmptyArray where T == NonEmptyString {

    var asStringArray: [String] {
        return (withTransformation { $0.value }).value
    }

    func joined(_ separator: String) -> NonEmptyString {
        let joinedValue = asStringArray.joined(separator: separator)
        return NonEmptyString(knownNonEmptyValue: joinedValue)
    }

}
