//
//  DecodableService.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2018 Justin Peckner. All rights reserved.
//

import Foundation

public enum DecodableServiceError<P: Decodable & Equatable>: Error, Equatable {
    // If we do get an error, in theory it should have come from the API, containing a known error payload format
    case errorPayloadReturned(P, HTTPURLResponse)

    // Any other error is unexpected
    case unexpected(DecodableServiceUnexpectedError)
}

public enum DecodableServiceUnexpectedError: Error, Equatable {
    case httpServiceError(underlyingError: HTTPServiceError)
    case noDataReturned(URLResponse)
    case failedToDecodeObject(Data, HTTPURLResponse, underlyingError: IgnoredEquatable<Error>)
    case failedToDecodeErrorPayload(Data, HTTPURLResponse, underlyingError: IgnoredEquatable<Error>)
}

public typealias DecodableServiceResult<
    T: Decodable,
    P: Decodable & Equatable
> = Result<T, DecodableServiceError<P>>

public typealias DecodableServiceCompletion<
    T: Decodable,
    P: Decodable & Equatable
> = (DecodableServiceResult<T, P>) -> Void

public protocol DecodableServiceProtocol {
    func performRequest<T: Decodable, P: Decodable & Equatable>(_ urlRequest: URLRequest,
                                                                completion: @escaping DecodableServiceCompletion<T, P>)
}

public class DecodableService: DecodableServiceProtocol {

    private let httpService: HTTPServiceProtocol
    private let decoder: DecoderProtocol

    public init(httpService: HTTPServiceProtocol,
                decoder: DecoderProtocol) {
        self.httpService = httpService
        self.decoder = decoder
    }

    public func performRequest<T: Decodable, P: Decodable & Equatable>(
        _ urlRequest: URLRequest,
        completion: @escaping DecodableServiceCompletion<T, P>
    ) {
        httpService.performHTTPRequest(urlRequest, successStatusCodes: [200]) { [weak self] result in
            switch result {
            case .success(let response):
                self?.handleHTTPResponse(response, completion: completion)
            case .failure(let error):
                self?.handleHTTPError(error, completion: completion)
            }
        }
    }

    private func handleHTTPResponse<T: Decodable, P: Decodable & Equatable>(
        _ response: HTTPServiceResponse,
        completion: @escaping DecodableServiceCompletion<T, P>
    ) {
        switch response {
        case let .withHTTPData(data, httpURLResponse):
            do {
                let decodedObject = try decoder.decode(T.self, from: data)
                completion(.success(decodedObject))
            } catch {
                completion(.failure(.unexpected(.failedToDecodeObject(data,
                                                                      httpURLResponse,
                                                                      underlyingError: IgnoredEquatable(error)))))
            }
        case .sansHTTPData(let urlResponse):
            completion(.failure(.unexpected(.noDataReturned(urlResponse))))
        }
    }

    private func handleHTTPError<T: Decodable, P: Decodable & Equatable>(
        _ error: HTTPServiceError,
        completion: @escaping DecodableServiceCompletion<T, P>
    ) {
        switch error {
        case let .nonSuccessfulStatusCode(data, httpURLResponse):
            guard let data = data else {
                completion(.failure(.unexpected(.httpServiceError(underlyingError: error))))
                return
            }

            do {
                let decodedErrorPayload = try decoder.decode(P.self, from: data)
                completion(.failure(.errorPayloadReturned(decodedErrorPayload, httpURLResponse)))
            } catch {
                completion(.failure(.unexpected(.failedToDecodeErrorPayload(data,
                                                                            httpURLResponse,
                                                                            underlyingError: IgnoredEquatable(error)))))
            }
        case .networkDataServiceError,
             .unexpectedResponseType:
            completion(.failure(.unexpected(.httpServiceError(underlyingError: error))))
        }
    }

}
