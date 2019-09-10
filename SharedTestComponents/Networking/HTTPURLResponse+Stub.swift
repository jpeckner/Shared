//
//  HTTPURLResponse+Stub.swift
//  SharedTestComponents
//
//  Created by Justin Peckner.
//  Copyright © 2018 Justin Peckner. All rights reserved.
//

import Foundation

public extension HTTPURLResponse {

    // swiftlint:disable force_unwrapping
    static func stubValue(url: URL = URL.stubValue(),
                          statusCode: Int = 200,
                          httpVersion: String? = nil,
                          headerFields: [String: String]? = nil) -> HTTPURLResponse {
        return HTTPURLResponse(url: url,
                               statusCode: statusCode,
                               httpVersion: httpVersion,
                               headerFields: headerFields)!
    }
    // swiftlint:enable force_unwrapping

}
