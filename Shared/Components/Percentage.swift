//
//  Percentage.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

import Foundation

public struct Percentage: Hashable {
    public static let oneHundredPercent = Percentage(value: 1.0)
    public static let zeroPercent = Percentage(value: 0.0)

    public let value: Double

    public init(decimalOf value: Double) {
        self.value = value - floor(value)
    }

    private init(value: Double) {
        self.value = value
    }
}
