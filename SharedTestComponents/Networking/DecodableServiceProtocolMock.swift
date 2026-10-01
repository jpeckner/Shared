//
//  DecodableServiceProtocolMock.swift
//  Shared
//
//  Copyright (c) 2026 Justin Peckner
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
import Shared

public class DecodableServiceProtocolMock<TOuterEntity: Decodable, TOuterErrorPayload: Decodable>: DecodableServiceProtocol, @unchecked Sendable {

    public enum ErrorPalette: Error {
        case declaredTypesDoNotMatch
    }

    public init() {}

    //MARK: - performRequest<TEntity: Decodable, TErrorPayload: Decodable>

    public var performRequestUrlRequestCallsCount = 0
    public var performRequestUrlRequestCalled: Bool {
        return performRequestUrlRequestCallsCount > 0
    }
    public var performRequestUrlRequestReceivedUrlRequest: URLRequest?
    public var performRequestUrlRequestReceivedInvocations: [URLRequest] = []
    public var performRequestUrlRequestReturnValue: DecodableServiceResult<TOuterEntity, TOuterErrorPayload>!
    public var performRequestUrlRequestClosure: ((URLRequest) async -> DecodableServiceResult<TOuterEntity, TOuterErrorPayload>)?

    public func performRequest<TEntity: Decodable, TErrorPayload: Decodable>(
        urlRequest: URLRequest
    ) async -> DecodableServiceResult<TEntity, TErrorPayload> {
        performRequestUrlRequestCallsCount += 1
        performRequestUrlRequestReceivedUrlRequest = urlRequest
        performRequestUrlRequestReceivedInvocations.append(urlRequest)
        if let performRequestUrlRequestClosure {
            let result = await performRequestUrlRequestClosure(urlRequest)
            if let returnedResult = result as? DecodableServiceResult<TEntity, TErrorPayload> {
                return returnedResult
            } else {
                return .failure(.unexpected(.other(underlyingError: ErrorPalette.declaredTypesDoNotMatch)))
            }
        } else {
            if let returnedResult = performRequestUrlRequestReturnValue as? DecodableServiceResult<TEntity, TErrorPayload> {
                return returnedResult
            } else {
                return .failure(.unexpected(.other(underlyingError: ErrorPalette.declaredTypesDoNotMatch)))
            }
        }
    }

}
