//
//  DecodableServiceTests.swift
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

class DecodableServiceTests: QuickSpec {

    // swiftlint:disable function_body_length
    // swiftlint:disable implicitly_unwrapped_optional
    // swiftlint:disable line_length
    override func spec() {

        let stubData = Data(1...5)
        let dummyURLRequest = URLRequest.stubValue()
        let stubURLResponse = HTTPURLResponse.stubValue()

        var mockHTTPService: HTTPServiceProtocolMock!
        var mockDecoder: DecoderProtocolMock!
        var decodableService: DecodableService!

        var returnedResult: DecodableServiceResult<StubDecodable, StubDecodableErrorPayload>!

        beforeEach {
            mockHTTPService = HTTPServiceProtocolMock()
            mockDecoder = DecoderProtocolMock()
            decodableService = DecodableService(httpService: mockHTTPService,
                                                decoder: mockDecoder)
        }

        describe("performRequest") {

            context("when the HTTPService passes back a .success result") {

                context("and that result contains a .withData instance") {

                    beforeEach {
                        let success = HTTPServiceSuccess(data: stubData,
                                                         response: stubURLResponse)
                        mockHTTPService.performHTTPRequestUrlRequestSuccessStatusCodesReturnValue = .success(success)
                    }

                    context("and the data successfully decodes to an object") {

                        let stubDecodable = StubDecodable(stringValue: "ABCDEFG",
                                                          intValue: 100,
                                                          doubleValue: 1.5)

                        beforeEach { _ in
                            mockDecoder.decodeFromReturnValue = stubDecodable

                            returnedResult = await decodableService.performRequest(urlRequest: dummyURLRequest)
                        }

                        it("passes back the decoded object") {
                            guard case let .success(returnedDecodable) = returnedResult else {
                                fail("Unexpected result: \(String(describing: returnedResult))")
                                return
                            }

                            expect(returnedDecodable) == stubDecodable
                        }

                    }

                    context("and the data fails to decode to an object") {

                        beforeEach { _ in
                            mockDecoder.decodeFromThrowableError = StubError.plainError

                            returnedResult = await decodableService.performRequest(urlRequest: dummyURLRequest)
                        }

                        it("passes back error .failedToDecodeObject") {
                            guard case let .failure(returnedError) = returnedResult,
                                case let .unexpected(unexpectedError) = returnedError,
                                case let .failedToDecodeObject(data, urlResponse, underlyingError) = unexpectedError
                            else {
                                fail("Unexpected result: \(String(describing: returnedResult))")
                                return
                            }

                            expect(data) == stubData
                            expect(urlResponse) == stubURLResponse
                            expect(underlyingError as? StubError) == .plainError
                        }

                    }

                }

            }

            context("else when the HTTPService passes back a .failure(.nonSuccessfulStatusCode) result") {

                beforeEach {
                    mockHTTPService.performHTTPRequestUrlRequestSuccessStatusCodesReturnValue =
                        .failure(.nonSuccessfulStatusCode(stubData, stubURLResponse))
                }

                context("and its data decodes to an error payload object") {

                    let stubErrorPayload = StubDecodableErrorPayload(error: "Something blew up!")

                    beforeEach { _ in
                        mockDecoder.decodeFromReturnValue = stubErrorPayload

                        returnedResult = await decodableService.performRequest(urlRequest: dummyURLRequest)
                    }

                    it("passes back error .errorPayloadReturned") {
                        guard case let .failure(returnedError) = returnedResult,
                              case let .errorPayloadReturned(errorPayload, urlResponse) = returnedError
                        else {
                            fail("Unexpected result: \(String(describing: returnedResult))")
                            return
                        }

                        expect(errorPayload) == stubErrorPayload
                        expect(urlResponse) == stubURLResponse
                    }

                }

                context("and its data fails to decode to an error payload object") {

                    beforeEach { _ in
                        mockDecoder.decodeFromThrowableError = StubError.plainError

                        returnedResult = await decodableService.performRequest(urlRequest: dummyURLRequest)
                    }

                    it("passes back error .failedToDecodeErrorPayload") {
                        guard case let .failure(returnedError) = returnedResult,
                              case let .unexpected(unexpectedError) = returnedError,
                              case let .failedToDecodeErrorPayload(data, urlResponse, underlyingError) = unexpectedError
                        else {
                            fail("Unexpected result: \(String(describing: returnedResult))")
                            return
                        }

                        expect(data) == stubData
                        expect(urlResponse) == stubURLResponse
                        expect(underlyingError as? StubError) == .plainError
                    }

                }

            }

            context("else when the HTTPService passes back a .failure(.unexpectedResponseType) result") {

                let stubHTTPServiceError = HTTPServiceError.unexpectedResponseType(stubData, stubURLResponse)

                beforeEach { _ in
                    mockHTTPService.performHTTPRequestUrlRequestSuccessStatusCodesReturnValue =
                        .failure(stubHTTPServiceError)

                    returnedResult = await decodableService.performRequest(urlRequest: dummyURLRequest)
                }

                it("passes back error .httpServiceError") {
                    guard case let .failure(.unexpected(.httpServiceError(error))) = returnedResult,
                          case let .unexpectedResponseType(data, urlResponse) = error as? HTTPServiceError
                    else {
                        fail("Unexpected result: \(String(describing: returnedResult))")
                        return
                    }

                    expect(data) == stubData
                    expect(urlResponse) == stubURLResponse
                }

            }

            context("else when the HTTPService passes back a .failure(.networkDataServiceError) result") {

                let stubHTTPServiceError = HTTPServiceError.networkDataServiceError(IgnoredEquatable(StubError.plainError))

                beforeEach { _ in
                    mockHTTPService.performHTTPRequestUrlRequestSuccessStatusCodesReturnValue =
                        .failure(stubHTTPServiceError)

                    returnedResult = await decodableService.performRequest(urlRequest: dummyURLRequest)
                }

                it("passes back error .httpServiceError") {
                    guard case let .failure(.unexpected(.httpServiceError(error))) = returnedResult,
                          case let .networkDataServiceError(underlyingError) = error as? HTTPServiceError
                    else {
                        fail("Unexpected result: \(String(describing: returnedResult))")
                        return
                    }

                    expect(underlyingError.value as? StubError) == .plainError
                }

            }

        }

    }

}
