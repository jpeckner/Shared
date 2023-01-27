//
//  DecodableService.swift
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

public enum DecodableServiceError<TErrorPayload: Decodable>: Error {
    // If we do get an error, in theory it should have come from the API, containing a known error payload format
    case errorPayloadReturned(TErrorPayload, HTTPURLResponse)

    // Any other error is unexpected
    case unexpected(DecodableServiceUnexpectedError)
}

public enum DecodableServiceUnexpectedError: Error {
    case httpServiceError(underlyingError: Error)
    case noDataReturned(URLResponse)
    case failedToDecodeObject(Data, HTTPURLResponse, underlyingError: Error)
    case failedToDecodeErrorPayload(Data, HTTPURLResponse, underlyingError: Error)
}

public typealias DecodableServiceResult<
    TEntity: Decodable,
    TErrorPayload: Decodable
> = Result<TEntity, DecodableServiceError<TErrorPayload>>

public protocol DecodableServiceProtocol {
    func performRequest<TEntity: Decodable, TErrorPayload: Decodable>(
        urlRequest: URLRequest
    ) async -> DecodableServiceResult<TEntity, TErrorPayload>
}

public class DecodableService: DecodableServiceProtocol {

    private let httpService: HTTPServiceProtocol
    private let decoder: DecoderProtocol

    public init(httpService: HTTPServiceProtocol,
                decoder: DecoderProtocol) {
        self.httpService = httpService
        self.decoder = decoder
    }

    public func performRequest<TEntity: Decodable, TErrorPayload: Decodable>(
        urlRequest: URLRequest
    ) async -> DecodableServiceResult<TEntity, TErrorPayload> {
        let httpResult = await httpService.performHTTPRequest(urlRequest: urlRequest,
                                                              successStatusCodes: [200])

        switch httpResult {
        case let .success(success):
            return handleHTTPResponse(data: success.data,
                                      response: success.response)

        case let .failure(error):
            return handleHTTPError(error: error)
        }
    }

    private func handleHTTPResponse<TEntity: Decodable, TErrorPayload: Decodable>(
        data: Data,
        response: HTTPURLResponse
    ) -> DecodableServiceResult<TEntity, TErrorPayload> {
        do {
            let decodedObject = try decoder.decode(TEntity.self, from: data)
            return .success(decodedObject)
        } catch {
            return .failure(.unexpected(.failedToDecodeObject(data,
                                                              response,
                                                              underlyingError: error)))
        }
    }

    private func handleHTTPError<TEntity: Decodable, TErrorPayload: Decodable>(
        error: HTTPServiceError
    ) -> DecodableServiceResult<TEntity, TErrorPayload> {
        switch error {
        case let .nonSuccessfulStatusCode(data, httpURLResponse):
            do {
                let decodedErrorPayload = try decoder.decode(TErrorPayload.self, from: data)
                return .failure(.errorPayloadReturned(decodedErrorPayload, httpURLResponse))
            } catch {
                return .failure(.unexpected(.failedToDecodeErrorPayload(data,
                                                                        httpURLResponse,
                                                                        underlyingError: error)))
            }

        case .networkDataServiceError,
             .unexpectedResponseType:
            return .failure(.unexpected(.httpServiceError(underlyingError: error)))
        }
    }

}
