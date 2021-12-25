//
//  NetworkDataServiceTests.swift
//  SharedTests
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
import Nimble
import Quick
import Shared
import SharedTestComponents

class NetworkDataServiceTests: QuickSpec {

    // swiftlint:disable function_body_length
    // swiftlint:disable implicitly_unwrapped_optional
    override func spec() {

        let stubData = Data(1...5)
        let stubResponse = URLResponse()
        let stubError = StubError.plainError
        let dummyURLRequest = URLRequest.stubValue()

        var mockURLSession: URLSessionProtocolMock<URLSessionDataTaskProtocolMock>!
        var responseQueue: DispatchQueue!
        var networkDataService: NetworkDataService<URLSessionProtocolMock<URLSessionDataTaskProtocolMock>>!

        beforeEach {
            mockURLSession = URLSessionProtocolMock()
            mockURLSession.dataTaskWithCompletionHandlerReturnValue = URLSessionDataTaskProtocolMock()
            responseQueue = DispatchQueue(label: "NetworkDataServiceTests")
            networkDataService = NetworkDataService(urlSession: mockURLSession, responseQueue: responseQueue)
        }

        describe("performDataTask") {

            var returnedResult: NetworkDataServiceResult!

            func performTest(_ data: Data?, urlResponse: URLResponse?, error: Error?) {
                networkDataService.performDataTask(dummyURLRequest) { result in
                    returnedResult = result
                }
                let receivedCompletionHandler = mockURLSession.dataTaskWithCompletionHandlerReceivedArguments?.1

                waitUntil(timeout: 0.25) { done in
                    receivedCompletionHandler?(data, urlResponse, error)
                    done()
                }
            }

            context("when a non-nil error is received in the completion handler") {

                context("and a nil data/nil response is received in the completion handler") {

                    beforeEach {
                        performTest(nil,
                                    urlResponse: nil,
                                    error: stubError)
                    }

                    it("passes back .failure(.requestError)") {
                        expect(returnedResult) == .failure(.requestError(underlyingError: IgnoredEquatable(stubError),
                                                                         response: nil))
                    }

                }

                context("and a nil data/non-nil response is received in the completion handler") {

                    beforeEach {
                        performTest(nil,
                                    urlResponse: stubResponse,
                                    error: stubError)
                    }

                    it("passes back .failure(.requestError)") {
                        expect(returnedResult) == .failure(.requestError(underlyingError: IgnoredEquatable(stubError),
                                                                         response: stubResponse))
                    }

                }

            }

            context("else when a non-nil response is received in the completion handler") {

                context("and a non-nil data is received in the completion handler") {

                    beforeEach {
                        performTest(stubData,
                                    urlResponse: stubResponse,
                                    error: nil)
                    }

                    it("passes back .success(.withData)") {
                        expect(returnedResult) == .success(.withData(stubData, stubResponse))
                    }

                }

                context("and a nil data is received in the completion handler") {

                    beforeEach {
                        performTest(nil,
                                    urlResponse: stubResponse,
                                    error: nil)
                    }

                    it("passes back .success(.sansData)") {
                        expect(returnedResult) == .success(.sansData(stubResponse))
                    }

                }

            }

            context("else when a non-nil data is received in the completion handler") {

                context("and a nil response/nil error are received in the completion handler") {

                    beforeEach {
                        performTest(stubData,
                                    urlResponse: nil,
                                    error: nil)
                    }

                    it("passes back .failure(.unexpectedResponseArgs)") {
                        expect(returnedResult) == .failure(.unexpectedResponseArgs(stubData,
                                                                                   nil,
                                                                                   nil))
                    }

                }

                context("and a nil response/non-nil error are received in the completion handler") {

                    beforeEach {
                        performTest(stubData,
                                    urlResponse: nil,
                                    error: stubError)
                    }

                    it("passes back .failure(.unexpectedResponseArgs)") {
                        expect(returnedResult) == .failure(.unexpectedResponseArgs(stubData,
                                                                                   nil,
                                                                                   IgnoredEquatable(stubError)))
                    }

                }

                context("and a non-nil response/non-nil error are received in the completion handler") {

                    beforeEach {
                        performTest(stubData,
                                    urlResponse: stubResponse,
                                    error: stubError)
                    }

                    it("passes back .failure(.unexpectedResponseArgs)") {
                        expect(returnedResult) == .failure(.unexpectedResponseArgs(stubData,
                                                                                   stubResponse,
                                                                                   IgnoredEquatable(stubError)))
                    }

                }

            }

            context("else when all three params are nil") {

                beforeEach {
                    performTest(nil,
                                urlResponse: nil,
                                error: nil)
                }

                it("passes back .failure(.unexpectedResponseArgs)") {
                    expect(returnedResult) == .failure(.unexpectedResponseArgs(nil,
                                                                               nil,
                                                                               nil))
                }

            }

        }

    }

}
