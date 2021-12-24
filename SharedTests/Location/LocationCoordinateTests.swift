//
//  LocationCoordinateTests.swift
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

class LocationCoordinateTests: QuickSpec {

    // swiftlint:disable implicitly_unwrapped_optional
    override func spec() {

        describe("init(location:)") {
            let stubCLLocation = CLLocation(latitude: 1234,
                                            longitude: 5678)

            var result: LocationCoordinate!

            beforeEach {
                result = LocationCoordinate(location: stubCLLocation)
            }

            it("returns a LocationCoordinate with the same latitude") {
                expect(result.latitude) == 1234
            }

            it("returns a LocationCoordinate with the same longitude") {
                expect(result.longitude) == 5678
            }
        }

        describe("clCoordinate") {
            let stubLocationCoordinate = LocationCoordinate(latitude: 1234,
                                                            longitude: 5678)

            var result: CLLocationCoordinate2D!

            beforeEach {
                result = stubLocationCoordinate.clCoordinate
            }

            it("returns a CLLocationCoordinate2D with the same latitude") {
                expect(result.latitude) == 1234
            }

            it("returns a CLLocationCoordinate2D with the same longitude") {
                expect(result.longitude) == 5678
            }
        }

    }

}
