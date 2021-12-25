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
