//
//  LocationCoordinateTests.swift
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
