//
//  NoOpAssertionHandler.swift
//  SharedTestComponents
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

import Shared

public enum NoOpAssertionHandler: AssertionHandlerProtocol {
    public static func performAssert(_ expression: () -> Bool,
                                     _ errorMessage: () -> String) {}

    public static func performAssertionFailure(_ errorMessage: () -> String) {}

    public static func assertIfErrorThrown(block: () throws -> Void) {}
}
