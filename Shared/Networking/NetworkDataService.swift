//
//  NetworkDataService.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2018 Justin Peckner. All rights reserved.
//

import Foundation

public enum NetworkDataServiceResponse: Equatable {
    case withData(Data, URLResponse)
    case sansData(URLResponse)
}

extension NetworkDataServiceResponse {

    var data: Data? {
        switch self {
        case .withData(let data, _):
            return data
        case .sansData:
            return nil
        }
    }

    var urlResponse: URLResponse {
        switch self {
        case .withData(_, let urlResponse),
             .sansData(let urlResponse):
            return urlResponse
        }
    }

}

public enum NetworkDataServiceError: Error, Equatable {
    case requestError(underlyingError: IgnoredEquatable<Error>, response: URLResponse?)
    case unexpectedResponseArgs(Data?, URLResponse?, IgnoredEquatable<Error>?)
    case otherError(IgnoredEquatable<Error>)
}

public typealias NetworkDataServiceResult = Result<NetworkDataServiceResponse, NetworkDataServiceError>
public typealias NetworkDataServiceCompletion = (NetworkDataServiceResult) -> Void

public protocol NetworkDataServiceProtocol: AutoMockable {
    func performDataTask(_ urlRequest: URLRequest,
                         completion: @escaping NetworkDataServiceCompletion)
}

public class NetworkDataService<TSession: URLSessionProtocol>: NetworkDataServiceProtocol {

    private let urlSession: TSession
    private let responseQueue: DispatchQueue

    public init(urlSession: TSession,
                responseQueue: DispatchQueue) {
        self.urlSession = urlSession
        self.responseQueue = responseQueue
    }

    public func performDataTask(_ request: URLRequest,
                                completion: @escaping NetworkDataServiceCompletion) {
        let dataTask: TSession.TSessionDataTask =
            urlSession.dataTask(with: request) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
                self?.responseQueue.async {
                    self?.processResponse(data,
                                          response: response,
                                          error: error,
                                          completion: completion)
                }
            }

        dataTask.resume()
    }

    private func processResponse(_ data: Data?,
                                 response: URLResponse?,
                                 error: Error?,
                                 completion: @escaping NetworkDataServiceCompletion) {
        if let error: Error = error {
            if data == nil {
                let networkError = NetworkDataServiceError.requestError(underlyingError: IgnoredEquatable(error),
                                                                        response: response)
                completion(Result.failure(networkError))
            } else {
                // Per https://developer.apple.com/documentation/foundation/urlsession/1407613-datatask -
                // "If the request fails, the data parameter is nil and the error parameter contain [sic]
                // information about the failure." So we should NOT have non-nil Data here.
                let networkError = NetworkDataServiceError.unexpectedResponseArgs(data,
                                                                                  response,
                                                                                  IgnoredEquatable(error))
                completion(Result.failure(networkError))
            }
        } else if let urlResponse = response {
            if let data: Data = data {
                completion(Result.success(NetworkDataServiceResponse.withData(data, urlResponse)))
            } else {
                completion(Result.success(NetworkDataServiceResponse.sansData(urlResponse)))
            }
        } else {
            // This catch-all should also never happen; it doesn't make sense for there to be non-nil Data if
            // urlResponse is nil, and also doesn't make sense for all three args to be nil.
            let networkError = NetworkDataServiceError.unexpectedResponseArgs(data,
                                                                              response,
                                                                              error.map { IgnoredEquatable($0) })
            completion(Result.failure(networkError))
        }
    }

}
