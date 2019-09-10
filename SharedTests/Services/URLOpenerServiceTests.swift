//
//  URLOpenerServiceTests.swift
//  SharedTests
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

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
