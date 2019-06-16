//
//  URLRequest+Init.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2018 Justin Peckner. All rights reserved.
//

import Foundation

public enum URLRequestType: String {
    case GET

    var httpMethod: String {
        return rawValue
    }
}

public extension URLRequest {

    init(url: URL,
         type: URLRequestType,
         headers: [String: String] = [:]) {
        self.init(url: url)

        httpMethod = type.httpMethod
        for (headerName, headerValue) in headers {
            setValue(headerValue, forHTTPHeaderField: headerName)
        }
    }

}
