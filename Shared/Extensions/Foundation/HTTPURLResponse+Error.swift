//
//  HTTPURLResponse+Error.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

import Foundation

public extension HTTPURLResponse {

    var is400Error: Bool {
        return 400...499 ~= statusCode
    }

    var is500Error: Bool {
        return 500...599 ~= statusCode
    }

}
