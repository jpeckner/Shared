//
//  HTTPService.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2018 Justin Peckner. All rights reserved.
//

import Foundation

public enum HTTPServiceResponse: Equatable {
    case withHTTPData(Data, HTTPURLResponse)
    case sansHTTPData(HTTPURLResponse)
}

public enum HTTPServiceError: Error, Equatable {
    case networkDataServiceError(NetworkDataServiceError)
    case unexpectedResponseType(Data?, URLResponse)
    case nonSuccessfulStatusCode(Data?, HTTPURLResponse)
}

public typealias HTTPServiceResult = Result<HTTPServiceResponse, HTTPServiceError>
public typealias HTTPServiceCompletion = (HTTPServiceResult) -> Void

public protocol HTTPServiceProtocol: AutoMockable {
    func performHTTPRequest(_ urlRequest: URLRequest,
                            successStatusCodes: Set<Int>,
                            completion: @escaping HTTPServiceCompletion)
}

public class HTTPService: HTTPServiceProtocol {

    private let networkDataService: NetworkDataServiceProtocol

    public init(networkDataService: NetworkDataServiceProtocol) {
        self.networkDataService = networkDataService
    }

    public func performHTTPRequest(_ urlRequest: URLRequest,
                                   successStatusCodes: Set<Int>,
                                   completion: @escaping HTTPServiceCompletion) {
        networkDataService.performDataTask(urlRequest) { [weak self] result in
            switch result {
            case .success(let response):
                self?.processNetworkDataServiceResponse(response,
                                                        successStatusCodes: successStatusCodes,
                                                        completion: completion)
            case .failure(let error):
                completion(.failure(.networkDataServiceError(error)))
            }
        }
    }

    private func processNetworkDataServiceResponse(_ response: NetworkDataServiceResponse,
                                                   successStatusCodes: Set<Int>,
                                                   completion: @escaping HTTPServiceCompletion) {
        let data = response.data
        guard let httpURLResponse = response.urlResponse as? HTTPURLResponse else {
            completion(.failure(.unexpectedResponseType(data, response.urlResponse)))
            return
        }

        guard successStatusCodes.contains(httpURLResponse.statusCode) else {
            completion(.failure(.nonSuccessfulStatusCode(data, httpURLResponse)))
            return
        }

        switch response {
        case let .withData(data, _):
            completion(.success(.withHTTPData(data, httpURLResponse)))
        case .sansData:
            completion(.success(.sansHTTPData(httpURLResponse)))
        }
    }

}
