//
//  DecodableServiceTests.swift
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
                        mockHTTPService.performHTTPRequestSuccessStatusCodesCompletionClosure = { _, _, completion in
                            completion(.success(.withHTTPData(stubData, stubURLResponse)))
                        }
                    }

                    context("and the data successfully decodes to an object") {

                        let stubDecodable = StubDecodable(stringValue: "ABCDEFG",
                                                          intValue: 100,
                                                          doubleValue: 1.5)

                        beforeEach {
                            mockDecoder.decodeFromReturnValue = stubDecodable

                            decodableService.performRequest(dummyURLRequest) { result in
                                returnedResult = result
                            }
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

                        beforeEach {
                            mockDecoder.decodeFromThrowableError = StubError.plainError

                            decodableService.performRequest(dummyURLRequest) { result in
                                returnedResult = result
                            }
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

                context("and that result contains a .sansData instance") {

                    beforeEach {
                        mockHTTPService.performHTTPRequestSuccessStatusCodesCompletionClosure = { _, _, completion in
                            completion(.success(.sansHTTPData(stubURLResponse)))
                        }

                        decodableService.performRequest(dummyURLRequest) { result in
                            returnedResult = result
                        }
                    }

                    it("passes back error .noDataReturned") {
                        guard case let .failure(returnedError) = returnedResult,
                            case let .unexpected(unexpectedError) = returnedError,
                            case let .noDataReturned(urlResponse) = unexpectedError
                        else {
                            fail("Unexpected result: \(String(describing: returnedResult))")
                            return
                        }

                        expect(urlResponse) == stubURLResponse
                    }

                }

            }

            context("else when the HTTPService passes back a .failure(.nonSuccessfulStatusCode) result") {

                context("and its data arg is not nil") {

                    beforeEach {
                        mockHTTPService.performHTTPRequestSuccessStatusCodesCompletionClosure = { _, _, completion in
                            completion(.failure(.nonSuccessfulStatusCode(stubData, stubURLResponse)))
                        }
                    }

                    context("and its data decodes to an error payload object") {

                        let stubErrorPayload = StubDecodableErrorPayload(error: "Something blew up!")

                        beforeEach {
                            mockDecoder.decodeFromReturnValue = stubErrorPayload

                            decodableService.performRequest(dummyURLRequest) { result in
                                returnedResult = result
                            }
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

                        beforeEach {
                            mockDecoder.decodeFromThrowableError = StubError.plainError

                            decodableService.performRequest(dummyURLRequest) { result in
                                returnedResult = result
                            }
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

                context("and its data arg is nil") {

                    let stubHTTPServiceError = HTTPServiceError.nonSuccessfulStatusCode(nil, stubURLResponse)

                    beforeEach {
                        mockHTTPService.performHTTPRequestSuccessStatusCodesCompletionClosure = { _, _, completion in
                            completion(.failure(stubHTTPServiceError))
                        }

                        decodableService.performRequest(dummyURLRequest) { result in
                            returnedResult = result
                        }
                    }

                    it("passes back error .httpServiceError") {
                        guard case let .failure(returnedError) = returnedResult,
                            case let .unexpected(unexpectedError) = returnedError,
                            case let .httpServiceError(underlyingError) = unexpectedError
                        else {
                            fail("Unexpected result: \(String(describing: returnedResult))")
                            return
                        }

                        expect(underlyingError) == stubHTTPServiceError
                    }

                }

            }

            context("else when the HTTPService passes back a .failure(.unexpectedResponseType) result") {

                let stubHTTPServiceError = HTTPServiceError.unexpectedResponseType(stubData, stubURLResponse)

                beforeEach {
                    mockHTTPService.performHTTPRequestSuccessStatusCodesCompletionClosure = { _, _, completion in
                        completion(.failure(stubHTTPServiceError))
                    }

                    decodableService.performRequest(dummyURLRequest) { result in
                        returnedResult = result
                    }
                }

                it("passes back error .httpServiceError") {
                    guard case let .failure(returnedError) = returnedResult,
                        case let .unexpected(unexpectedError) = returnedError,
                        case let .httpServiceError(underlyingError) = unexpectedError
                    else {
                        fail("Unexpected result: \(String(describing: returnedResult))")
                        return
                    }

                    expect(underlyingError) == stubHTTPServiceError
                }

            }

            context("else when the HTTPService passes back a .failure(.networkDataServiceError) result") {

                let stubHTTPServiceError = HTTPServiceError.networkDataServiceError(.unexpectedResponseArgs(
                    nil,
                    nil,
                    nil
                ))

                beforeEach {
                    mockHTTPService.performHTTPRequestSuccessStatusCodesCompletionClosure = { _, _, completion in
                        completion(.failure(stubHTTPServiceError))
                    }

                    decodableService.performRequest(dummyURLRequest) { result in
                        returnedResult = result
                    }
                }

                it("passes back error .httpServiceError") {
                    guard case let .failure(returnedError) = returnedResult,
                        case let .unexpected(unexpectedError) = returnedError,
                        case let .httpServiceError(underlyingError) = unexpectedError
                    else {
                        fail("Unexpected result: \(String(describing: returnedResult))")
                        return
                    }

                    expect(underlyingError) == stubHTTPServiceError
                }

            }

        }

    }

}
