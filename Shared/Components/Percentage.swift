//
//  Percentage.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

import Foundation

public struct Percentage: Hashable {
    public static let oneHundredPercent = Percentage(fromPercentageInt: 100)
    public static let zeroPercent = Percentage(fromPercentageInt: 0)

    public let value: Double

    public init(decimalOf value: Double) {
        self.value = value - floor(value)
    }

    public init(fromPercentageInt value: Int) {
        self.value = Double(value) / 100.0
    }
}
