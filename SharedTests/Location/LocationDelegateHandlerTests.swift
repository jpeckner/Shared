//
//  LocationDelegateHandlerTests.swift
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

class LocationDelegateHandlerTests: QuickSpec {

    // swiftlint:disable function_body_length
    // swiftlint:disable implicitly_unwrapped_optional
    override func spec() {

        let stubDateManagerInitialized = Date()
        let stubEarlierLocations = [
            CLLocationProtocolStub(
                coordinate: CLLocationCoordinate2D(latitude: 5.0, longitude: 5.0),
                timestamp: stubDateManagerInitialized.addingTimeInterval(1.0),
                horizontalAccuracy: 1.0
            ),
            CLLocationProtocolStub(
                coordinate: CLLocationCoordinate2D(latitude: 10.0, longitude: 10.0),
                timestamp: stubDateManagerInitialized.addingTimeInterval(1.0),
                horizontalAccuracy: 1.0
            ),
        ]

        var locationDelegateHandler: LocationDelegateHandler!
        var result: LocationRequestResult?

        beforeEach {
            locationDelegateHandler = LocationDelegateHandler()
        }

        describe("resultForDidUpdateLocations") {

            context("when locations is empty") {
                beforeEach {
                    result = locationDelegateHandler.resultForDidUpdateLocations(
                        [],
                        dateManagerInitialized: stubDateManagerInitialized
                    )
                }

                it("returns failure with a .noLocationsReturned error") {
                    expect(result) == .failure(.noLocationsReturned)
                }
            }

            context("else when the last object in locations has a timestamp earlier than dateManagerInitialized") {
                let locations = stubEarlierLocations + [
                    CLLocationProtocolStub(
                        coordinate: CLLocationCoordinate2D(latitude: 15.0, longitude: 15.0),
                        timestamp: stubDateManagerInitialized.addingTimeInterval(-1.0),
                        horizontalAccuracy: 10.0
                    )
                ]

                beforeEach {
                    result = locationDelegateHandler.resultForDidUpdateLocations(
                        locations,
                        dateManagerInitialized: stubDateManagerInitialized
                    )
                }

                it("returns nil") {
                    expect(result).to(beNil())
                }
            }

            context("else when the last object in locations has a negative horizontalAccuracy") {
                let locations = stubEarlierLocations + [
                    CLLocationProtocolStub(
                        coordinate: CLLocationCoordinate2D(latitude: 15.0, longitude: 15.0),
                        timestamp: stubDateManagerInitialized.addingTimeInterval(1.0),
                        horizontalAccuracy: -1.0
                    )
                ]

                beforeEach {
                    result = locationDelegateHandler.resultForDidUpdateLocations(
                        locations,
                        dateManagerInitialized: stubDateManagerInitialized
                    )
                }

                it("returns failure with a .invalidHorizontalAccuracy error") {
                    expect(result) == .failure(.invalidHorizontalAccuracy)
                }
            }

            context("else") {
                let locations = stubEarlierLocations + [
                    CLLocationProtocolStub(
                        coordinate: CLLocationCoordinate2D(latitude: 15.0, longitude: 15.0),
                        timestamp: stubDateManagerInitialized.addingTimeInterval(1.0),
                        horizontalAccuracy: 1.0
                    )
                ]

                beforeEach {
                    result = locationDelegateHandler.resultForDidUpdateLocations(
                        locations,
                        dateManagerInitialized: stubDateManagerInitialized
                    )
                }

                it("returns success with a LocationCoordinate equivalent to the last object in locations") {
                    let expectedCoordinate = LocationCoordinate(location: locations[locations.count - 1])
                    expect(result) == .success(expectedCoordinate)
                }
            }

        }

        describe("resultForDidFailWithError") {

            context("when error is not a CLError") {
                beforeEach {
                    result = locationDelegateHandler.resultForDidFailWithError(StubError.plainError)
                }

                it("returns failure with an .unknownError error") {
                    expect(result) == .failure(.unknownError(IgnoredEquatable(StubError.plainError)))
                }
            }

            context("else when error is a CLError") {

                context("and the error's code is locationUnknown") {
                    beforeEach {
                        result = locationDelegateHandler.resultForDidFailWithError(CLError(.locationUnknown))
                    }

                    it("returns nil") {
                        expect(result).to(beNil())
                    }
                }

                context("and the error's code is not locationUnknown") {
                    let clError = CLError(.deferredAccuracyTooLow)

                    beforeEach {
                        result = locationDelegateHandler.resultForDidFailWithError(clError)
                    }

                    it("calls back with a .coreLocationError error") {
                        expect(result) == .failure(.coreLocationError(clError))
                    }
                }

            }

        }

    }

}
