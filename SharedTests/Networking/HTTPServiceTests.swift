//
//  HTTPServiceTests.swift
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

class HTTPServiceTests: QuickSpec {

    // swiftlint:disable function_body_length
    // swiftlint:disable implicitly_unwrapped_optional
    override func spec() {

        let stubData = Data(1...5)
        let dummyURLRequest = URLRequest.stubValue()
        let stubURLResponse = HTTPURLResponse.stubValue()

        var mockURLSession: URLSessionProtocolMock!
        var httpService: HTTPService!

        var returnedResult: HTTPServiceResult!

        beforeEach {
            mockURLSession = URLSessionProtocolMock()
            httpService = HTTPService(urlSession: mockURLSession)
        }

        describe("performHTTPRequest") {

            context("when the NetworkDataService passes back a .success result") {

                context("and that result holds a URLResponse that is not an HTTPURLResponse") {

                    let nonHTTPResponse = URLResponse()

                    beforeEach { _ in
                        mockURLSession.dataForReturnValue = (stubData, nonHTTPResponse)

                        returnedResult = await httpService.performHTTPRequest(urlRequest: dummyURLRequest,
                                                                              successStatusCodes: [200])
                    }

                    it("passes back .failure(.unexpectedResponseType)") {
                        guard case let .failure(.unexpectedResponseType(data, httpResponse)) = returnedResult else {
                            fail("Unexpected value found: \(String(describing: returnedResult))")
                            return
                        }

                        expect(data) == stubData
                        expect(httpResponse) == nonHTTPResponse
                    }

                }

                context("and that result holds an HTTP status code not included in successStatusCodes") {

                    let errorURLResponse = HTTPURLResponse.stubValue(statusCode: 400)

                    beforeEach { _ in
                        mockURLSession.dataForReturnValue = (stubData, errorURLResponse)

                        returnedResult = await httpService.performHTTPRequest(urlRequest: dummyURLRequest,
                                                                              successStatusCodes: [200])
                    }

                    it("passes back .failure(.nonSuccessfulStatusCode)") {
                        guard case let .failure(.nonSuccessfulStatusCode(data, httpResponse)) = returnedResult else {
                            fail("Unexpected value found: \(String(describing: returnedResult))")
                            return
                        }

                        expect(data) == stubData
                        expect(httpResponse) == errorURLResponse
                    }

                }

                context("and that result holds non-nil Data") {

                    beforeEach { _ in
                        mockURLSession.dataForReturnValue = (stubData, stubURLResponse)

                        returnedResult = await httpService.performHTTPRequest(urlRequest: dummyURLRequest,
                                                                              successStatusCodes: [200])
                    }

                    it("passes back .success(.withHTTPData)") {
                        guard case let .success(success) = returnedResult else {
                            fail("Unexpected value found: \(String(describing: returnedResult))")
                            return
                        }

                        expect(success.data) == stubData
                        expect(success.response) == stubURLResponse
                    }

                }

            }

            context("else when the NetworkDataService throws a .failure result") {
                let stubNetworkServiceError = StubError.plainError

                beforeEach { _ in
                    mockURLSession.dataForThrowableError = stubNetworkServiceError

                    returnedResult = await httpService.performHTTPRequest(urlRequest: dummyURLRequest,
                                                                          successStatusCodes: [200])
                }

                it("passes back .failure(.networkDataServiceError)") {
                    guard case let .failure(.networkDataServiceError(error)) = returnedResult else {
                        fail("Unexpected value found: \(String(describing: returnedResult))")
                        return
                    }

                    expect(error.value as? StubError) == stubNetworkServiceError
                }
            }

        }

    }

}
