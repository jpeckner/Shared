//
//  LocationRequestHandlerTests.swift
//  SharedTests
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

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
