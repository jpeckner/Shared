//
//  URLComponents+Stub.swift
//  SharedTestComponents
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

import Foundation

public extension URLComponents {

    // swiftlint:disable force_unwrapping
    static func stubValue(url: URL = URL.stubValue()) -> URLComponents {
        return URLComponents(url: url,
                             resolvingAgainstBaseURL: true)!
    }
    // swiftlint:enable force_unwrapping

}
