//
//  UIColorInitTests.swift
//  SharedTests
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

import Foundation
import Nimble
import Quick
import Shared
import SharedTestComponents

class UIColorInitTests: QuickSpec {

    // swiftlint:disable object_literal
    // swiftlint:disable function_body_length
    override func spec() {

        describe("init(:hexString)") {

            var thrownError: Error?
            var result: UIColor?

            func performTest(hexString: String) {
                thrownError = errorThrownBy {
                    result = try UIColor(hexString: hexString)
                }
            }

            context("when the string is not a valid hex string") {
                beforeEach {
                    performTest(hexString: "FFFFFG")
                }

                it("throws an error") {
                    expect(thrownError).toNot(beNil())
                }
            }

            context("when the hex value is greater than 0xFFFFFF") {
                beforeEach {
                    performTest(hexString: "1000000")
                }

                it("throws an error") {
                    expect(thrownError).toNot(beNil())
                }
            }

            context("when the string is equal to 0xFFFFFF") {
                beforeEach {
                    performTest(hexString: "FFFFFF")
                }

                it("returns the corresponding UIColor, with an alpha of 1.0") {
                    expect(result) == UIColor(red: 1.0,
                                              green: 1.0,
                                              blue: 1.0,
                                              alpha: 1.0)
                }
            }

            context("when the string is equal to 0x000000") {
                beforeEach {
                    performTest(hexString: "000000")
                }

                it("returns the corresponding UIColor, with an alpha of 1.0") {
                    expect(result) == UIColor(red: 0.0,
                                              green: 0.0,
                                              blue: 0.0,
                                              alpha: 1.0)
                }
            }

            context("when the string is in-between those limits") {
                beforeEach {
                    performTest(hexString: "FEDCBA")
                }

                it("returns the corresponding UIColor, with an alpha of 1.0") {
                    expect(result) == UIColor(red: CGFloat(254.0) / 255.0,
                                              green: CGFloat(220.0) / 255.0,
                                              blue: CGFloat(186.0) / 255.0,
                                              alpha: 1.0)
                }
            }

            context("when the string includes a 0x prefix") {
                beforeEach {
                    performTest(hexString: "0xFEDCBA")
                }

                it("returns the same result as no-prefix") {
                    expect(result) == UIColor(red: CGFloat(254.0) / 255.0,
                                              green: CGFloat(220.0) / 255.0,
                                              blue: CGFloat(186.0) / 255.0,
                                              alpha: 1.0)
                }
            }

        }

    }

}
