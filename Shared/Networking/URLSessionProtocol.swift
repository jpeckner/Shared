//
//  URLSessionProtocol.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

import Foundation

public protocol URLSessionDataTaskProtocol: AutoMockable {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}

// sourcery: genericTypes = "TSessionDataTask: URLSessionDataTaskProtocol"
public protocol URLSessionProtocol: AutoMockable {
    associatedtype TSessionDataTask: URLSessionDataTaskProtocol

    func dataTask(with request: URLRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> TSessionDataTask
}

extension URLSession: URLSessionProtocol {}
