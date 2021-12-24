//
//  URLOpenerServiceTests.swift
//  SharedTests
//
//  Copyright (c) 2019 Justin Peckner
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

import Nimble
import Quick
import Shared
import SharedTestComponents

class URLOpenerServiceTests: QuickSpec {

    // swiftlint:disable function_body_length
    // swiftlint:disable implicitly_unwrapped_optional
    override func spec() {

        var mockURLOpener: URLOpenerProtocolMock!
        var service: URLOpenerService!

        func buildTestComponents(mockURLOpener: URLOpenerProtocolMock) {
            service = URLOpenerService(urlOpener: mockURLOpener)
        }

        beforeEach {
            URLOpenerProtocolMock.openSettingsURLString = ""
        }

        describe("init") {

            context("when openSettingsURLString is not a valid URL") {
                beforeEach {
                    URLOpenerProtocolMock.openSettingsURLString = ""
                    mockURLOpener = URLOpenerProtocolMock()
                    mockURLOpener.canOpenURLReturnValue = true
                    buildTestComponents(mockURLOpener: mockURLOpener)
                }

                it("initializes openSettingsBlock to nil") {
                    expect(service.openSettingsBlock).to(beNil())
                }
            }

            context("else when mockURLOpener.canOpenURL() returns false") {
                beforeEach {
                    URLOpenerProtocolMock.openSettingsURLString = "https://www.example.com"
                    mockURLOpener = URLOpenerProtocolMock()
                    mockURLOpener.canOpenURLReturnValue = false
                    buildTestComponents(mockURLOpener: mockURLOpener)
                }

                it("initializes openSettingsBlock to nil") {
                    expect(service.openSettingsBlock).to(beNil())
                }
            }

            context("else") {
                beforeEach {
                    URLOpenerProtocolMock.openSettingsURLString = "https://www.example.com"
                    mockURLOpener = URLOpenerProtocolMock()
                    mockURLOpener.canOpenURLReturnValue = true
                    buildTestComponents(mockURLOpener: mockURLOpener)
                }

                it("initializes openSettingsBlock to a value") {
                    expect(service.openSettingsBlock).toNot(beNil())
                }

                it("calls open() on mockURLOpener when openSettingsBlock is invoked") {
                    expect(mockURLOpener.openOptionsCompletionHandlerReceivedArguments).to(beNil())

                    service.openSettingsBlock?()
                    expect(mockURLOpener.openOptionsCompletionHandlerReceivedArguments?.0.absoluteString)
                        == "https://www.example.com"
                }
            }
        }

        describe("buildPhoneCallBlock()") {

            var result: OpenURLBlock?

            context("when mockURLOpener.canOpenURL() returns false") {
                beforeEach {
                    mockURLOpener = URLOpenerProtocolMock()
                    mockURLOpener.canOpenURLReturnValue = false
                    buildTestComponents(mockURLOpener: mockURLOpener)
                    result = service.buildPhoneCallBlock(.stubValue("+15555555555"))
                }

                it("returns nil") {
                    expect(result).to(beNil())
                }
            }

            context("else") {
                beforeEach {
                    mockURLOpener = URLOpenerProtocolMock()
                    mockURLOpener.canOpenURLReturnValue = true
                    buildTestComponents(mockURLOpener: mockURLOpener)
                    result = service.buildPhoneCallBlock(.stubValue("+15555555555"))
                }

                it("initializes openSettingsBlock to a value") {
                    expect(result).toNot(beNil())
                }

                it("calls open() on mockURLOpener when the returned block is invoked") {
                    expect(mockURLOpener.openOptionsCompletionHandlerReceivedArguments).to(beNil())

                    result?()
                    expect(mockURLOpener.openOptionsCompletionHandlerReceivedArguments?.0.absoluteString)
                        == "tel:+15555555555"
                }
            }
        }

    }

}
