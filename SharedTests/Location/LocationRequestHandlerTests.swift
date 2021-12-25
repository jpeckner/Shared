//
//  LocationRequestHandlerTests.swift
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

import CoreLocation
import Foundation
import Nimble
import Quick
import Shared
import SharedTestComponents

class LocationRequestHandlerTests: QuickSpec {

    // swiftlint:disable function_body_length
    // swiftlint:disable implicitly_unwrapped_optional
    override func spec() {

        let dummyLocationManager = CLLocationManager()

        var mockLocationManager: CLLocationManagerRequestProtocolMock!
        var mockDelegateHandler: LocationDelegateHandlerProtocolMock!
        var locationRequestHandler: LocationRequestHandler!

        beforeEach {
            mockLocationManager = CLLocationManagerRequestProtocolMock()
            mockDelegateHandler = LocationDelegateHandlerProtocolMock()

            locationRequestHandler = LocationRequestHandler(locationManager: mockLocationManager,
                                                            delegateHandler: mockDelegateHandler)
        }

        describe("requestLocation") {
            beforeEach {
                locationRequestHandler.requestLocation { _ in }
            }

            it("calls mockLocationManager.startUpdatingLocation()") {
                expect(mockLocationManager.startUpdatingLocationCalled).toEventually(beTrue())
            }
        }

        describe("CLLocationManagerDelegate") {

            describe("didUpdateLocations") {

                context("when mockDelegateHandler returns a non-nil value from resultForDidUpdateLocations") {
                    let stubResult = LocationRequestResult.success(LocationCoordinate(latitude: 10.0, longitude: 10.0))
                    let numSubscribers = 3
                    let expectedReceivedResults = Array(repeating: stubResult, count: numSubscribers)

                    var receivedResults: [LocationRequestResult]!

                    beforeEach {
                        mockDelegateHandler.resultForDidUpdateLocationsDateManagerInitializedReturnValue = stubResult

                        receivedResults = []
                        for _ in 0..<numSubscribers {
                            locationRequestHandler.requestLocation { result in
                                receivedResults.append(result)
                            }
                        }

                        locationRequestHandler.locationManager(dummyLocationManager,
                                                               didUpdateLocations: [])
                    }

                    it("calls mockLocationManager.stopUpdatingLocation()") {
                        expect(mockLocationManager.stopUpdatingLocationCalled) == true
                    }

                    it("calls back each subscriber with the value") {
                        expect(receivedResults).toEventually(equal(expectedReceivedResults))
                    }

                    context("when didUpdateLocations is again called before subscribers call requestLocation()") {
                        beforeEach {
                            locationRequestHandler.locationManager(dummyLocationManager,
                                                                   didUpdateLocations: [])
                        }

                        it("does not call back the subscribers a second time") {
                            expect(receivedResults).toEventually(equal(expectedReceivedResults))
                        }
                    }
                }

            }

            describe("didFailWithError") {

                context("when mockDelegateHandler returns a non-nil value from resultForDidFailWithError") {
                    let stubResult = LocationRequestResult.failure(.noLocationsReturned)
                    let numSubscribers = 3
                    let expectedReceivedResults = Array(repeating: stubResult, count: numSubscribers)

                    var receivedResults: [LocationRequestResult]!

                    beforeEach {
                        mockDelegateHandler.resultForDidFailWithErrorReturnValue = stubResult

                        receivedResults = []
                        for _ in 0..<numSubscribers {
                            locationRequestHandler.requestLocation { result in
                                receivedResults.append(result)
                            }
                        }

                        locationRequestHandler.locationManager(dummyLocationManager,
                                                               didFailWithError: StubError.plainError)
                    }

                    it("calls mockLocationManager.stopUpdatingLocation()") {
                        expect(mockLocationManager.stopUpdatingLocationCalled) == true
                    }

                    it("calls back each subscriber with the value") {
                        expect(receivedResults).toEventually(equal(expectedReceivedResults))
                    }

                    context("when didUpdateLocations is again called before subscribers call requestLocation()") {
                        beforeEach {
                            locationRequestHandler.locationManager(dummyLocationManager,
                                                                   didFailWithError: StubError.plainError)
                        }

                        it("does not call back the subscribers a second time") {
                            expect(receivedResults).toEventually(equal(expectedReceivedResults))
                        }
                    }
                }

            }

        }

    }

}
