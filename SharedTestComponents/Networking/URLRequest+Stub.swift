//
//  URLRequest+Stub.swift
//  SharedTestComponents
//
//  Created by Justin Peckner.
//  Copyright © 2018 Justin Peckner. All rights reserved.
//

import Foundation

public extension URLRequest {

    static func stubValue(url: URL = URL.stubValue()) -> URLRequest {
        return URLRequest(url: url)
    }

}
