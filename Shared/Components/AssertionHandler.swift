//
//  AssertionHandler.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

import Foundation

public protocol AssertionHandlerProtocol {
    static func performAssert(_ expression: () -> Bool,
                              _ errorMessageBlock: () -> String)

    static func performAssertionFailure(_ errorMessageBlock: () -> String)

    static func assertIfErrorThrown(block: () throws -> Void)
}

public enum AssertionHandler: AssertionHandlerProtocol {

    public static func performAssert(_ expression: () -> Bool,
                                     _ errorMessageBlock: () -> String) {
        assert(expression(), errorMessageBlock())
    }

    public static func performAssertionFailure(_ errorMessageBlock: () -> String) {
        assertionFailure(errorMessageBlock())
    }

    public static func assertIfErrorThrown(block: () throws -> Void) {
        do {
            try block()
        } catch {
            performAssertionFailure { "Unexpected error: \(error)" }
        }
    }

}
