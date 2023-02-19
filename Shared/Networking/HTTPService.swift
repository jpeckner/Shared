//
//  HTTPService.swift
//  Shared
//
//  Copyright (c) 2018 Justin Peckner
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import Foundation

public struct HTTPServiceSuccess: Sendable {
    public let data: Data
    public let response: HTTPURLResponse

    public init(data: Data, response: HTTPURLResponse) {
        self.data = data
        self.response = response
    }
}

public enum HTTPServiceError: Error, Sendable {
    case networkDataServiceError(IgnoredEquatable<Error>)
    case unexpectedResponseType(Data, URLResponse)
    case nonSuccessfulStatusCode(Data, HTTPURLResponse)
}

public typealias HTTPServiceResult = Result<HTTPServiceSuccess, HTTPServiceError>

// sourcery:AutoMockable
public protocol HTTPServiceProtocol: Sendable {
    func performHTTPRequest(urlRequest: URLRequest,
                            successStatusCodes: Set<Int>) async -> HTTPServiceResult
}

public actor HTTPService: HTTPServiceProtocol {

    private let urlSession: URLSessionProtocol

    public init(urlSession: URLSessionProtocol) {
        self.urlSession = urlSession
    }

    public func performHTTPRequest(urlRequest: URLRequest,
                                   successStatusCodes: Set<Int>) async -> HTTPServiceResult {
        do {
            let (data, urlResponse) = try await urlSession.data(for: urlRequest)
            
            guard let httpURLResponse = urlResponse as? HTTPURLResponse else {
                return .failure(.unexpectedResponseType(data, urlResponse))
            }

            guard successStatusCodes.contains(httpURLResponse.statusCode) else {
                return .failure(.nonSuccessfulStatusCode(data, httpURLResponse))
            }
            
            let success = HTTPServiceSuccess(data: data,
                                             response: httpURLResponse)
            return .success(success)
        } catch {
            return .failure(.networkDataServiceError(IgnoredEquatable(error)))
        }
    }

}
