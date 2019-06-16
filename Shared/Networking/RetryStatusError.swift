//
//  RetryStatusError.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

import Foundation

public protocol RetryStatusError: Error {
    var isRetriable: Bool { get }
}
