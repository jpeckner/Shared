// swiftlint:disable:this file_name
//
//  CLLocationCoordinate2D+LocationTests.swift
//  SharedTests
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

import CoreLocation
import Nimble
import Quick
import Shared
import SharedTestComponents

class CLLocationCoordinate2DLocationTests: QuickSpec {

    // swiftlint:disable implicitly_unwrapped_optional
    override func spec() {

        describe("clLocation") {
            let stub2DCoordinate = CLLocationCoordinate2D(latitude: 1234,
                                                          longitude: 5678)

            var result: CLLocation!

            beforeEach {
                result = stub2DCoordinate.clLocation
            }

            it("returns a CLLocation with the same latitude") {
                expect(result.coordinate.latitude) == 1234
            }

            it("returns a CLLocation with the same longitude") {
                expect(result.coordinate.longitude) == 5678
            }
        }

    }

}
