//
//  DecodableService.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2018 Justin Peckner. All rights reserved.
//

import Foundation

public enum DecodableServiceError<TErrorPayload: Decodable>: Error {
    // If we do get an error, in theory it should have come from the API, containing a known error payload format
    case errorPayloadReturned(TErrorPayload, HTTPURLResponse)

    // Any other error is unexpected
    case unexpected(DecodableServiceUnexpectedError)
}

public enum DecodableServiceUnexpectedError: Error {
    case httpServiceError(underlyingError: HTTPServiceError)
    case noDataReturned(URLResponse)
    case failedToDecodeObject(Data, HTTPURLResponse, underlyingError: Error)
    case failedToDecodeErrorPayload(Data, HTTPURLResponse, underlyingError: Error)
}

public typealias DecodableServiceResult<
    TEntity: Decodable,
    TErrorPayload: Decodable
> = Result<TEntity, DecodableServiceError<TErrorPayload>>

public typealias DecodableServiceCompletion<
    TEntity: Decodable,
    TErrorPayload: Decodable
> = (DecodableServiceResult<TEntity, TErrorPayload>) -> Void

public protocol DecodableServiceProtocol {
    func performRequest<TEntity: Decodable, TErrorPayload: Decodable>(
        _ urlRequest: URLRequest,
        completion: @escaping DecodableServiceCompletion<TEntity, TErrorPayload>
    )
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
        _ urlRequest: URLRequest,
        completion: @escaping DecodableServiceCompletion<TEntity, TErrorPayload>
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

    private func handleHTTPResponse<TEntity: Decodable, TErrorPayload: Decodable>(
        _ response: HTTPServiceResponse,
        completion: @escaping DecodableServiceCompletion<TEntity, TErrorPayload>
    ) {
        switch response {
        case let .withHTTPData(data, httpURLResponse):
            do {
                let decodedObject = try decoder.decode(TEntity.self, from: data)
                completion(.success(decodedObject))
            } catch {
                completion(.failure(.unexpected(.failedToDecodeObject(data,
                                                                      httpURLResponse,
                                                                      underlyingError: error))))
            }
        case .sansHTTPData(let urlResponse):
            completion(.failure(.unexpected(.noDataReturned(urlResponse))))
        }
    }

    private func handleHTTPError<TEntity: Decodable, TErrorPayload: Decodable>(
        _ error: HTTPServiceError,
        completion: @escaping DecodableServiceCompletion<TEntity, TErrorPayload>
    ) {
        switch error {
        case let .nonSuccessfulStatusCode(data, httpURLResponse):
            guard let data = data else {
                completion(.failure(.unexpected(.httpServiceError(underlyingError: error))))
                return
            }

            do {
                let decodedErrorPayload = try decoder.decode(TErrorPayload.self, from: data)
                completion(.failure(.errorPayloadReturned(decodedErrorPayload, httpURLResponse)))
            } catch {
                completion(.failure(.unexpected(.failedToDecodeErrorPayload(data,
                                                                            httpURLResponse,
                                                                            underlyingError: error))))
            }
        case .networkDataServiceError,
             .unexpectedResponseType:
            completion(.failure(.unexpected(.httpServiceError(underlyingError: error))))
        }
    }

}
