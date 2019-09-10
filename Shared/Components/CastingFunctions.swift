//
//  CastingFunctions.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

import Foundation

public enum CastError: Error {
    case failedToCast(
        expectedType: String,
        actualType: String
    )
}

public enum CastingFunctions {

    public static func cast<T>(_ any: Any) throws -> T {
        guard let asT = any as? T else {
            throw CastError.failedToCast(
                expectedType: String(describing: T.self),
                actualType: String(describing: type(of: any))
            )
        }

        return asT
    }

}
