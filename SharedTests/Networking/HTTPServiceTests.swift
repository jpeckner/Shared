//
//  HTTPServiceTests.swift
//  SharedTests
//
//  Created by Justin Peckner.
//  Copyright © 2018 Justin Peckner. All rights reserved.
//

import Foundation
import Nimble
import Quick
import Shared
import SharedTestComponents

class HTTPServiceTests: QuickSpec {

    // swiftlint:disable function_body_length
    // swiftlint:disable implicitly_unwrapped_optional
    override func spec() {

        let stubData = Data(1...5)
        let dummyURLRequest = URLRequest.stubValue()
        let stubURLResponse = HTTPURLResponse.stubValue()

        var mockNetworkDataService: NetworkDataServiceProtocolMock!
        var httpService: HTTPService!

        var returnedResult: HTTPServiceResult!

        beforeEach {
            mockNetworkDataService = NetworkDataServiceProtocolMock()
            httpService = HTTPService(networkDataService: mockNetworkDataService)
        }

        describe("performHTTPRequest") {

            context("when the NetworkDataService passes back a .success result") {

                context("and that result holds a URLResponse that is not an HTTPURLResponse") {

                    let nonHTTPResponse = URLResponse()

                    beforeEach {
                        mockNetworkDataService.performDataTaskCompletionClosure = { _, completion in
                            completion(.success(.withData(stubData, nonHTTPResponse)))
                        }

                        httpService.performHTTPRequest(dummyURLRequest, successStatusCodes: [200]) { result in
                            returnedResult = result
                        }
                    }

                    it("passes back .failure(.unexpectedResponseType)") {
                        expect(returnedResult) == .failure(.unexpectedResponseType(stubData, nonHTTPResponse))
                    }

                }

                context("and that result holds an HTTP status code not included in successStatusCodes") {

                    let errorURLResponse = HTTPURLResponse.stubValue(statusCode: 400)

                    beforeEach {
                        mockNetworkDataService.performDataTaskCompletionClosure = { _, completion in
                            completion(.success(.withData(stubData, errorURLResponse)))
                        }

                        httpService.performHTTPRequest(dummyURLRequest, successStatusCodes: [200]) { result in
                            returnedResult = result
                        }
                    }

                    it("passes back .failure(.nonSuccessfulStatusCode)") {
                        expect(returnedResult) == .failure(.nonSuccessfulStatusCode(stubData, errorURLResponse))
                    }

                }

                context("and that result holds non-nil Data") {

                    beforeEach {
                        mockNetworkDataService.performDataTaskCompletionClosure = { _, completion in
                            completion(.success(.withData(stubData, stubURLResponse)))
                        }

                        httpService.performHTTPRequest(dummyURLRequest,
                                                       successStatusCodes: [200]) { result in
                            returnedResult = result
                        }
                    }

                    it("passes back .success(.withHTTPData)") {
                        expect(returnedResult) == .success(.withHTTPData(stubData, stubURLResponse))
                    }

                }

                context("and that result holds nil Data") {

                    beforeEach {
                        mockNetworkDataService.performDataTaskCompletionClosure = { _, completion in
                            completion(.success(.sansData(stubURLResponse)))
                        }

                        httpService.performHTTPRequest(dummyURLRequest,
                                                       successStatusCodes: [200]) { result in
                            returnedResult = result
                        }
                    }

                    it("passes back .success(.sansHTTPData)") {
                        expect(returnedResult) == .success(.sansHTTPData(stubURLResponse))
                    }

                }

            }

            context("else when the NetworkDataService passes back a .failure result") {

                let stubNetworkServiceError = NetworkDataServiceError.unexpectedResponseArgs(nil,
                                                                                             nil,
                                                                                             IgnoredEquatable(nil))

                beforeEach {
                    mockNetworkDataService.performDataTaskCompletionClosure = { _, completion in
                        completion(.failure(stubNetworkServiceError))
                    }

                    httpService.performHTTPRequest(dummyURLRequest,
                                                   successStatusCodes: [200]) { result in
                        returnedResult = result
                    }
                }

                it("passes back .failure(.networkDataServiceError)") {
                    expect(returnedResult) == .failure(.networkDataServiceError(stubNetworkServiceError))
                }

            }

        }

    }

}
