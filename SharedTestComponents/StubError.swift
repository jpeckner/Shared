//
//  StubError.swift
//  SharedTests
//
//  Created by Justin Peckner.
//  Copyright © 2018 Justin Peckner. All rights reserved.
//

import Foundation
import Shared

public func errorThrownBy(_ block: () throws -> Void) -> Error? {
    do {
        try block()
        return nil
    } catch {
        return error
    }
}

// MARK: Error-related stub values

public enum StubError: Error {
    case plainError
    case thrownError
}
