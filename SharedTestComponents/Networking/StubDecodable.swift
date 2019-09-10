//
//  StubDecodable.swift
//  SharedTestComponents
//
//  Created by Justin Peckner.
//  Copyright © 2018 Justin Peckner. All rights reserved.
//

import Foundation

public struct StubDecodable: Decodable, Equatable {
    let stringValue: String
    let intValue: Int
    let doubleValue: Double

    public init(stringValue: String,
                intValue: Int,
                doubleValue: Double) {
        self.stringValue = stringValue
        self.intValue = intValue
        self.doubleValue = doubleValue
    }
}

public struct StubDecodableErrorPayload: Decodable, Equatable {
    let error: String

    public init(error: String) {
        self.error = error
    }
}
